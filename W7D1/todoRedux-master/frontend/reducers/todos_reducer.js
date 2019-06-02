import { RECEIVE_TODOS, RECEIVE_TODO } from "./../actions/todo_actions";

// total placeholder so great
const intialState = {
  1: {
    id: 1,
    title: "wash me",
    body: "with soap",
    done: false
  },
  2: {
    id: 2,
    title: "wash you",
    body: "with shampoo",
    done: true
  }
};

export default function todosReducer(state = intialState, action) {
  switch (action.type) {
    case RECEIVE_TODO:
      const newTodo = action.todo;
      const newState = Object.assign({}, state, newTodo);
      newState[newTodo.id] = newTodo;
      return newState;
    case RECEIVE_TODOS:
      const newTodos = {};
      action.todos.forEach(el => {
        newTodos[el.id] = el;
      });
      return newTodos;
    default:
      return state;
  }
}
