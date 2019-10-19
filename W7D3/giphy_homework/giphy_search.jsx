import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';
// import { fetchSearchGiphys } from './util/api_util'; // ah yeah that was your error lmao right need the brackets around it
import { receiveSearchGiphys, fetchSearchGiphys } from './actions/giphy_actions';



document.addEventListener('DOMContentLoaded', () => { // right this is how to do it document.addEventListener('DOMContentLoaded', callbackFunc); love it
  const store = configureStore();
  window.fetchSearchGiphys = fetchSearchGiphys;
  window.receiveSearchGiphys = receiveSearchGiphys;
  window.store = store;
});