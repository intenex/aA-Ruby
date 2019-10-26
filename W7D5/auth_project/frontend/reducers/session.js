import { RECEIVE_CURRENT_USER, LOGOUT_CURRENT_USER } from '../actions/session';

const _nullSession = {
  currentUser: null
};

export default (state = _nullSession, action) => { // omg you can export default fat arrow functions just not consts love it amazing so great to watch these videos
  Object.freeze(state);
  switch(action.type) {
    case RECEIVE_CURRENT_USER:
      return Object.assign({}, { currentUser: action.user });
    case LOGOUT_CURRENT_USER:
        return _nullSession; // just return the original null state awesome
    default:
      return state;
  }
};