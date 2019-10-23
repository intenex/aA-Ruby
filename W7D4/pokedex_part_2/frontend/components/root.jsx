import React from 'react';
import { Provider } from 'react-redux';
import { HashRouter, Route } from 'react-router-dom';
import PokemonIndexContainer from './pokemon/pokemon_index_container'; // right default export so you can call it whatever you want love it

const Root = ({store}) => ( // from props get the store specifically love it right you get passed a props object just destructure what attributes you want great
  <Provider store={store}>
    <HashRouter>
      <PokemonIndexContainer />
    </HashRouter>
  </Provider>
);

export default Root;