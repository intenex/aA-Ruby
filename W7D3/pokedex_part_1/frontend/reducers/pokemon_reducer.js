import { RECEIVE_ALL_POKEMON } from './../actions/pokemon_actions';

export default function pokemonReducer(state = {}, action) {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
      return action.pokemon; // the new slice of state should be this I think change it later if the state shape isn't the same
    default:
      return state;
  }
}