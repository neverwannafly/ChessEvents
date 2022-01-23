import puzzles from '@app/api/puzzles';

const PUZZLE_INIT = 'PUZZLE_INIT';
const PUZZLE_LOAD = 'PUZZLE_LOAD';
const PUZZLE_FAIL = 'PUZZLE_FAIL';

const initialState = {
  data: {},
  isLoading: false,
  error: null,
};

function serializePuzzleData(response) {
  const { puzzle: { slug } } = response;
  return [slug, { [slug]: response }];
}

export function randomPuzzle(afterFetch, strength) {
  return async (dispatch, getState) => {
    const { isLoading } = getState();

    if (isLoading) {
      return;
    }

    dispatch({ type: PUZZLE_INIT });
    try {
      const response = await puzzles.random(strength);
      const [slug, payload] = serializePuzzleData(response);

      dispatch({ type: PUZZLE_LOAD, payload });
      afterFetch(slug);
    } catch (err) {
      dispatch({ type: PUZZLE_FAIL, payload: err.message });
    }
  };
}

export function loadPuzzle(puzzleSlug) {
  return async (dispatch, getState) => {
    const { puzzles: { isLoading, data } } = getState();

    if (isLoading || data[puzzleSlug]) {
      return;
    }

    dispatch({ type: PUZZLE_INIT });
    try {
      const response = await puzzles.load(puzzleSlug);
      const [, payload] = serializePuzzleData(response);

      dispatch({ type: PUZZLE_LOAD, payload });
    } catch (err) {
      dispatch({ type: PUZZLE_FAIL, payload: err.message });
    }
  };
}

export default function (state = initialState, { type, payload }) {
  switch (type) {
    case PUZZLE_INIT:
      return { ...state, isLoading: true, error: null };
    case PUZZLE_LOAD:
      return { ...state, isLoading: false, data: payload };
    case PUZZLE_FAIL:
      return { ...state, isLoading: false, error: payload };
    default:
      return { ...state };
  }
}
