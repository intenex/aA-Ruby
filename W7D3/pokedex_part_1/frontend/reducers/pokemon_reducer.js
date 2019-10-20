import { RECEIVE_ALL_POKEMON } from './../actions/pokemon_actions';

export default function pokemonReducer(state = {}, action) {
  Object.freeze(state);
  switch (action.type) {
    default:
      return state;
  }
}