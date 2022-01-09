const USER_LOAD_INIT = 'USER_LOAD_INIT';
const USER_LOAD_DONE = 'USER_LOAD_DONE';
const USER_LOAD_FAIL = 'USER_LOAD_FAIL';

const initialState = {
  error: null,
  data: null,
  isLoading: false,
}

export default function(state = initialState, { type, payload }) {
  switch (type) {
    case USER_LOAD_INIT:
      return {
        ...state,
        isLoading: true,
        error: null,
        data: null,
      };
    case USER_LOAD_DONE:
      return {
        ...state,
        isLoading: false,
        data: payload,
      };
    case USER_LOAD_FAIL:
      return {
        ...state,
        isLoading: false,
        error: payload,
      }
    default:
      return { ...state };
  }
}
