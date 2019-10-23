import React from 'react';
import ReactDOM from 'react-dom';
import { HashRouter, Route } from 'react-router-dom';
import configureStore from './store/store';
import Root from './components/root.jsx';

document.addEventListener('DOMContentLoaded', () => { // document.addEventListener('DOMContentLoaded', callbackFunc) yep that's how to do it love it everything is on the document in vanillaDOM so great
  const root = document.getElementById('root');
  const store = configureStore();
  ReactDOM.render(<Root store={store} />, root);
});