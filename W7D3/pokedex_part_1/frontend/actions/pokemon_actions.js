import * as APIUTIL from './../util/api_util';
export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";

export const receiveAllPokemon = pokemon => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
}); // you really do remember it well at this point so lucky man keep pushing life is so great man so long since you've gotten a haircut since like the beginning of august hilarious 3 months lol

export const fetchAllPokemon = () => dispatch => (
  dispatch("Hello")
);