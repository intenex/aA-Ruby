import { RECEIVE_TODOS, RECEIVE_TODO } from './../actions/todo_actions';
import { merge } from 'lodash';

const initialState = { // note this is just for the todo slice of state as all the reducers are combined by the root reducer love it
  1: {
    id: 1,
    title: "wash car",
    body: "with soap",
    done: false
  },
  2: {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  }
};

const todosReducer = (state = initialState, action) => {
  switch (action.type) {
    case RECEIVE_TODOS:
      Object.freeze(state);
      let todo_objects = {};
      action.todos.forEach(todo => {
        todo_objects[todo.id] = todo;
      });
      return merge({}, todo_objects);
    case RECEIVE_TODO:
      Object.freeze(state);
      let newState = merge({}, state);
      newState[action.todo.id] = action.todo;
      return newState;
    default:
      return state;
  }
};

export default todosReducer;