export function allTodos({todo}) { // get the todos slice of state
  return Object.values(todo);
}

export function stepsByTodoId(state, todoId) {
  return Object.values(state.steps).filter(step => step.todo_id === todoId); // 
}