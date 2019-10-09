import combineReducers from 'redux';
import todosReducer from './todo_reducer';

const rootReducer = combineReducers({
  todo: todosReducer
});

export default rootReducer;