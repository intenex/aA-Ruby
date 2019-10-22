import { createStore, applyMiddleware } from 'redux';
import rootReducer from './../reducers/root_reducer';
import logger from 'redux-logger';
import thunk from './../middleware/thunk';

const configureStore = (initialState = {}) => (
  createStore(rootReducer, initialState, applyMiddleware(thunk, logger)) // thunk must be first to intercept functions otherwise they get logged by the logger etc
);

export default configureStore;