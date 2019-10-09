import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './frontend/store/store';

const store = configureStore();
window.store = store;

document.addEventListener("DOMContentLoaded", function() {
  const root = document.getElementById("root");
  ReactDOM.render(<h1>Todos App</h1>, root);
});