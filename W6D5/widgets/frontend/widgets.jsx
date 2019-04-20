import React from 'react';
import ReactDOM from 'react-dom';
import Root from './root';

document.addEventListener("DOMContentLoaded", (event) => {
  const root = document.getElementById('root');
  ReactDOM.render(<Root />, root);
});