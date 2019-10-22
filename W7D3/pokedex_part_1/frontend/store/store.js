import { createStore, applyMiddleware } from 'redux';
import rootReducer from './../reducers/root_reducer';
import logger from 'redux-logger';

const configureStore = (initialState = {}) => (
  createStore(rootReducer, initialState, applyMiddleware(logger))
);

export default configureStore;