import { RECEIVE_STEPS, RECEIVE_STEP, REMOVE_STEP } from './../actions/todo_actions':
import { merge } from 'lodash';

const stepsReducer = (state = {}, action) => {
  const newState = merge({}, state);
  switch (action.type) {
    default:
      return state;
  }
};

export default stepsReducer;