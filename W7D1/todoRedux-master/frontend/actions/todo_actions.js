export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";

// to receive just one todo
export const receiveTodo = todo => {
  return { type: RECEIVE_TODO, todo }; // this is todo: todo yep --> this is the todo object namespaced here yep
};

// to receive multiple todos at once yep
export const receiveTodos = todos => {
  return { type: RECEIVE_TODOS, todos }; // this is todos: todos object yep good object patterning
};

export const removeTodo = todo => {
  return { type: REMOVE_TODO, todo };
};