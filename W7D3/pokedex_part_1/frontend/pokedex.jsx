import React from 'react';
import ReactDOM from 'react-dom';
import { receiveAllPokemon } from './actions/pokemon_actions';
import { fetchAllPokemon } from './util/api_util';

document.addEventListener('DOMContentLoaded', () => { // document.addEventListener('DOMContentLoaded', callbackFunc) yep that's how to do it love it everything is on the document in vanillaDOM so great
  const root = document.getElementById('root');
  window.receiveAllPokemon = receiveAllPokemon;
  window.fetchAllPokemon = fetchAllPokemon;
  ReactDOM.render(<h1>Hi!</h1>, root);
});