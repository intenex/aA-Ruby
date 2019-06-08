import configureStore from "./store/store.js";
import Root from "./components/root";
import React from 'react';
import ReactDOM from 'react-dom';
import { allTodos } from './reducers/selectors';

// yep this is the entry file now you actually know all your code fucking dope
const store = configureStore();
window.store = store;
window.allTodos = allTodos;
window.React = React; // shouldn't need this line but something breaks in todo_list_container and todo_list without it look into it more hmm

document.addEventListener("DOMContentLoaded", (event) => {
    const rootElement = document.getElementById('root');
    ReactDOM.render(<Root store={store}/>, rootElement); // amazing JSX element it knows render takes these in so great
});