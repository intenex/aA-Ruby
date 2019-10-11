import { RECEIVE_STEPS, RECEIVE_STEP, REMOVE_STEP } from './../actions/todo_actions';
import { merge } from 'lodash';

const initialState = {
  1: {
    id: 1,
    title: 'walk to store',
    done: false,
    todo_id: 1
  },
  2: {
    id: 2,
    title: 'buy soap',
    done: false,
    todo_id: 1
  }
};

const stepsReducer = (state = initialState, action) => {
  Object.freeze(state);
  const newState = merge({}, state);
  switch (action.type) {
    case RECEIVE_STEPS:

    case RECEIVE_STEP:

    case REMOVE_STEP:

    default:
      return state;
  }
};

export default stepsReducer;