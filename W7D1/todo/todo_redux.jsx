import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './frontend/store/store';
import Root from './frontend/components/root';

const store = configureStore();

document.addEventListener("DOMContentLoaded", function() {
  const root = document.getElementById("root");
  ReactDOM.render(<Root store={store}/>, root);
});