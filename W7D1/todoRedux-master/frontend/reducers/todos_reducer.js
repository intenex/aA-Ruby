import { RECEIVE_TODOS, RECEIVE_TODO } from "./../actions/todo_actions";

const initialState = {
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

export default function todosReducer(state = initialState, action) { // if there is no state passed in set it to the default state this is true the first time this thing is called
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
