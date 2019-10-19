import * as APIUtil from '../util/api_util';

export const RECEIVE_SEARCH_GIPHYS = 'RECEIVE_SEARCH_GIPHYS';

export const receiveSearchGiphys = giphys => ({
  type: RECEIVE_SEARCH_GIPHYS,
  giphys
});

export const fetchSearchGiphys = searchTerm => dispatch => { // right thunk action creators return function objects that are passed into the reducer and intercepted by middleware 
  return new Promise((resolve, reject) => {

  });
};