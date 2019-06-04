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

// remember the state returned here is only actually for a slice of state not the entire state 
export default function todosReducer(state = initialState, action) { // if there is no state passed in set it to the default state this is true the first time this thing is called
  switch (action.type) {
    case RECEIVE_TODO: // if receiving a single todo
      const newTodo = action.todo; // the todo will be the object namespaced on the action object as .todo
      const newState = Object.assign({}, state); // Object.assign will assign all the values of state to the {} empty POJO and then for some reason pass the newTodo values over too to the {} not sure why or if that's correct hmm
      newState[newTodo.id] = newTodo; // this is correct --> this sets the correct attribute/key on newState to the value of the newTodo object
      return newState;
    case RECEIVE_TODOS:
      const newTodos = {}; // this is the entirety of the new slice of todos state // look more into hoisting of variables and all that for sure
      action.todos.forEach(el => { // yep for each todo set the new state's 
        newTodos[el.id] = el;
      });
      return newTodos;
    default: // if no action.type is found it'll run this basically the first time you run the reducer with nothing passed in
      return state;
  }
}
