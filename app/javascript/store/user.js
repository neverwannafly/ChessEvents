const SET_USER = 'SET_USER';
const UNSET_USER = 'UNSET_USER';

const initialState = {
  isLoggedin: false,
  username: '',
  name: '',
};

export const setUser = (payload) => (dispatch) => {
  dispatch({ type: SET_USER, payload });
};

export const unsetUser = () => (dispatch) => {
  dispatch({ type: UNSET_USER });
};

export default function (state = initialState, { type, payload }) {
  switch (type) {
    case SET_USER:
      return { ...state, isLoggedin: true, ...payload };
    case UNSET_USER:
      return { ...initialState };
    default:
      return { ...state };
  }
}
