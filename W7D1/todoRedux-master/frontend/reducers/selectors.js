export function allTodos(state) { // dope works flawlessly really grokking it now so lucky
  return Object.keys(state.todos).map(el => state.todos[el]); // wow your first real fat arrow implicit return thing fucking love it def get way more into this
}