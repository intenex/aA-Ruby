import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import { merge } from 'lodash';

import Root from './components/root';


// function applyMiddlewares(store, ...middlewares) { 
//   let dispatch = store.dispatch;
//   middlewares.forEach(middleware => {
//     dispatch = middleware(store)(dispatch); // this returns the final middleware function that just takes an action and finally executes, the dispatch will be the previous middleware each time now brilliant
//   });
//   return merge({}, store, { dispatch }); // rewrite dispatch in the store to your dispatch yep love it awesome that you build this all yourself now you've forgotten why merge is better than Object.assign some small nuance about assigning recursively children or something like that too right
// } // hmm no semicolon needed here yeah you thought so can't wait to get way more into all of this man programming is just so damn fun

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  let store = configureStore(preloadedState);

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});
