import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';
// import { fetchSearchGiphys } from './util/api_util'; // ah yeah that was your error lmao right need the brackets around it
import { receiveSearchGiphys, fetchSearchGiphys } from './actions/giphy_actions';

document.addEventListener('DOMContentLoaded', () => { // right this is how to do it document.addEventListener('DOMContentLoaded', callbackFunc); love it
  const store = configureStore(); // right you want the store in here as to not pollute the global namespace with your variables when it's only needed in here tons of reasons love it all man
  window.fetchSearchGiphys = fetchSearchGiphys;
  window.receiveSearchGiphys = receiveSearchGiphys;
  window.store = store;
  const root = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, root); 
});