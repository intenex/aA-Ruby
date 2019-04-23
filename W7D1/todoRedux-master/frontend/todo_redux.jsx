import configureStore from "./store/store.js";
import { receiveTodo, receiveTodos } from "./actions/todo_actions";

window.receiveTodo = receiveTodo;
window.receiveTodos = receiveTodos;

const store = configureStore();
window.store = store;
