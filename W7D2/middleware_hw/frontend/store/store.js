import { createStore, applyMiddleware } from 'redux';
import rootReducer from '../reducers/root_reducer';

const addLoggingToDispatch = ({ getState, dispatch }) => next => action => {
  console.log(`Old State: ${getState()}`);
  console.log(`Action: ${action}`);
  const result = next(action);
  console.log(`New State: ${getState()}`);
  return result;
};

const configureStore = (preloadedState = {}) => {
  const store = createStore(rootReducer, preloadedState, applyMiddleware(addLoggingToDispatch));
  store.subscribe(() => {
    localStorage.state = JSON.stringify(store.getState());
  });
  return store;
}

export default configureStore;
