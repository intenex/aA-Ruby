import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './frontend/store/store';
import Root from './frontend/components/root';
import { receiveTodos, receiveTodo } from './frontend/actions/todo_actions';

const store = configureStore();
window.store = store;
window.receiveTodos = receiveTodos;
window.receiveTodo = receiveTodo;

document.addEventListener("DOMContentLoaded", function() {
  const root = document.getElementById("root");
  ReactDOM.render(<Root store={store}/>, root);
});