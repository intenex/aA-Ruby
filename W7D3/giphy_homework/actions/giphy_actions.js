import * as APIUtil from '../util/api_util';

export const RECEIVE_SEARCH_GIPHYS = 'RECEIVE_SEARCH_GIPHYS';

export const receiveSearchGiphys = giphys => ({
  type: RECEIVE_SEARCH_GIPHYS,
  giphys
});

export const fetchSearchGiphys = searchTerm => dispatch => { // right thunk action creators return function objects that are passed into the reducer and intercepted by middleware, generally to run some async action
  APIUtil.fetchSearchGiphys(searchTerm) // right this is already async they just weren't clear though you can always find ways around it love all of that
    .then(retrievedGiphys => {
      dispatch(receiveSearchGiphys(retrievedGiphys));
    });
};