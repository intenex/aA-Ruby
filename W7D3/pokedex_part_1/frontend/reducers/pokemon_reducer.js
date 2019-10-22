import { RECEIVE_ALL_POKEMON } from './../actions/pokemon_actions';
import { merge } from 'lodash';

export default function pokemonReducer(state = {}, action) {
  Object.freeze(state);
  let newState = {};   
  switch (action.type) {
    case RECEIVE_ALL_POKEMON:
      action.pokemon.forEach(pokemon => {
        const pokemonObj = Object.values(pokemon)[0]; // only one value
        newState[pokemonObj.id] = pokemonObj;
      });
      return newState; // the new slice of state should be this I think change it later if the state shape isn't the same
    default:
      return state;
  }
}