import { RECEIVE_SEARCH_GIPHYS } from '../actions/giphy_actions';
// import { merge } from 'lodash';

const giphysReducer = (state = [], action) => {
  // Object.freeze(state);
  // let newState;
  switch (action.type) {
    case RECEIVE_SEARCH_GIPHYS:
      return action.giphys; // just an array awwright
    default:
      return state;
  }
};

export default giphysReducer;