import { createStore, applyMiddleware } from 'redux';
import rootReducer from '../reducers/root_reducer';

const addLoggingToDispatch = ({ getState }) => next => action => {
  console.log(`Old State: ${getState()}`);
  console.log(`Action: ${action}`);
  const result = next(action);
  console.log(`New State: ${getState()}`);
  return result;
};

const secondMiddleware = ({getState}) => next => action => {
  console.log(`Next middleware (aka the actual dispatch function since this is the last middleware lol): ${next}`);
  return next(action);
};

const configureStore = (preloadedState = {}) => {
  const store = createStore(rootReducer, preloadedState, applyMiddleware(addLoggingToDispatch, secondMiddleware));
  store.subscribe(() => {
    localStorage.state = JSON.stringify(store.getState());
  });
  return store;
}

export default configureStore;
