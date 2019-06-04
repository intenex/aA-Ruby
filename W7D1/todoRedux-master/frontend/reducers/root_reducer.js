import { combineReducers } from "redux";
import todosReducer from "./todos_reducer";

const rootReducer = combineReducers({
  todos: todosReducer // namespaced under todos --> the todos slice of the app state awesome see how you call this later
});

export default rootReducer;
