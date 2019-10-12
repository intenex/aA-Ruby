import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

const addLoggingToDispatch = ( {getState, dispatch} ) => action => {
  console.log(`Old State: ${getState()}`);
  console.log(`Action: ${action}`);
  dispatch(action);
  console.log(`New State: ${getState()}`);
};

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  const store = configureStore(preloadedState);

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});
