export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";
export const RECEIVE_STEPS = "RECEIVE_STEPS";
export const RECEIVE_STEP = "RECEIVE_STEP";
export const REMOVE_STEP = "REMOVE_STEP";

export const receiveTodos = todos => (
  {
    type: RECEIVE_TODOS,
    todos
  }
);

export const receiveTodo = todo => (
  {
    type: RECEIVE_TODO,
    todo
  }
);

export const removeTodo = todo => (
  {
    type: REMOVE_TODO,
    todo
  }
);

export const receiveSteps = steps => (
  {
    type: RECEIVE_STEPS,
    steps
  }
);

export const receiveStep = step => (
  {
    type: RECEIVE_STEP,
    step
  }
);

export const removeStep = step => (
  {
    type: REMOVE_STEP,
    step
  }
);