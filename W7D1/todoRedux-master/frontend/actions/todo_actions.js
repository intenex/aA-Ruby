export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";

// to receive just one todo
export const receiveTodo = todo => {
  return { type: RECEIVE_TODO, todo };
};

// to receive multiple todos at once yep
export const receiveTodos = todos => {
  return { type: RECEIVE_TODOS, todos };
};
