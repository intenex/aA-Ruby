import React from 'react';
import ReactDOM from 'react-dom';
import createStore from './store/store';
import Root from './components/root';

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root');
  let preloadedState = undefined; // right so if no preloadedState it doesn't do anything undefined will just not actually pass anything hmm right otherwise everytime you loaded it wouldn't actually fetch the logged in user from the server right now it just loads the initial state of nothing
  if (window.currentUser) {
    preloadedState = {
      session: {
        currentUser: window.currentUser
      }
    };
  }
  const store = createStore(preloadedState);
  // const store = createStore();

  ReactDOM.render(<Root store={store} />, root);
})