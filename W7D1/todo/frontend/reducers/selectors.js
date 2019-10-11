export function allTodos({todo}) { // get the todos slice of state
  return Object.values(todo);
}

export function stepsByTodoId(state, todoId) {
  console.log(state.steps);
  console.log(todoId);
  return Object.values(state.steps).filter(step => step.todo_id === todoId); // gets an array of all the steps, then filters to just return all the steps that return true for the function passed into the filer love it
}