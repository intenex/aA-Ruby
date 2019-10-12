import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import { merge } from 'lodash';

import Root from './components/root';

const addLoggingToDispatch = ( {getState, dispatch} ) => next => action => {
  console.log(`Old State: ${getState()}`);
  console.log(`Action: ${action}`);
  const result = next(action);
  console.log(`New State: ${getState()}`);
  return result;
};

function applyMiddlewares(store, ...middlewares) { 
  let dispatch = store.dispatch;
  middlewares.forEach(middleware => {
    dispatch = middleware(store)(dispatch); // this returns the final middleware function that just takes an action and finally executes, the dispatch will be the previous middleware each time now brilliant
  });
  return merge({}, store, { dispatch }); // rewrite dispatch in the
} // hmm no semicolon needed here yeah you thought so can't wait to get way more into all of this man programming is just so damn fun

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  const store = configureStore(preloadedState);
  store.dispatch = addLoggingToDispatch(store); // reassign the dispatch key to your new function hilarious lol amaizng you can do nuts stuff like this yeah amazing anti-pattern to avoid but so awesome you can do it

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});
