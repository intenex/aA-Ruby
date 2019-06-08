import configureStore from "./store/store.js";
import Root from "./components/root";
import React from 'react';
import ReactDOM from 'react-dom';

// yep this is the entry file now you actually know all your code fucking dope
const store = configureStore();

document.addEventListener("DOMContentLoaded", (event) => {
    const rootElement = document.getElementById('root');
    ReactDOM.render(<Root store={store}/>, rootElement); // amazing JSX element it knows render takes these in so great
});