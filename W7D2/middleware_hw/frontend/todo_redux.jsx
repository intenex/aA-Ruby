import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

const addLoggingToDispatch = ( {getState, dispatch} ) => next => action => {
  console.log(`Old State: ${getState()}`);
  console.log(`Action: ${action}`);
  const result = dispatch(action);
  console.log(`New State: ${getState()}`);
  return result;
};

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  const store = configureStore(preloadedState);
  store.dispatch = addLoggingToDispatch(store); // reassign the dispatch key to your new function hilarious lol amaizng you can do nuts stuff like this yeah amazing anti-pattern to avoid but so awesome you can do it

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});
