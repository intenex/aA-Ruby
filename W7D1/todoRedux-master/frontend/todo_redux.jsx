import configureStore from "./store/store.js";
import { receiveTodo, receiveTodos } from "./actions/todo_actions";
import Root from "./components/root";
import React from 'react';
import ReactDOM from 'react-dom';

const store = configureStore();
window.receiveTodo = receiveTodo;
window.receiveTodos = receiveTodos;
window.store = store;

document.addEventListener("DOMContentLoaded", (event) => {
    const rootElement = document.getElementById('root');
    ReactDOM.render(<Root store={store}/>, rootElement); // amazing JSX element it knows render takes these in so great
});