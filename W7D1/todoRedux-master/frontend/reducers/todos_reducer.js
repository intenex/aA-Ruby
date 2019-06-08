import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO } from "./../actions/todo_actions";

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
      return newState; // crazy that you found and fixed that bug you must have really not understood JS as well as you do now don't even understand how you put it in like this but good to know you really can understand this code and fix bugs easily and that that was a real bug from before fucking dope
    case RECEIVE_TODOS:
      const newTodos = {}; // this is the entirety of the new slice of todos state // look more into hoisting of variables and all that for sure
      action.todos.forEach(el => { // yep for each todo set the new state's 
        newTodos[el.id] = el;
      });
      return newTodos;
    case REMOVE_TODO:
      const modifiedState = Object.assign({}, state);
      delete modifiedState[action.todo.id]; // this is how to remove it p sure yep
      return modifiedState; // interesting so you either have a break or a return yeah makes sense a case statement inside a function can just return to get out of it love it 
    default: // if no action.type is found it'll run this basically the first time you run the reducer with nothing passed in
      return state;
  }
}
