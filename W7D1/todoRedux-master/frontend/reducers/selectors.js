export function allTodos(state) { // dope works flawlessly really grokking it now so lucky
  return Object.values(state.todos); // kind of impressive you did this with map but what the fuck lmao how were you writing code like this wtf glad to know you've actually leveled up in JS but also nuts that you were doing this though it's honestly impressive you could use .map like that didn't even know .map was a JS function anymore have to do way more code love this shit so much man
}

// ah yeah that's what a selector it this one selects all the todos in the state lol it returns all the todo objects lol kind of a weird way to select them though
// select all the keys of the state.todos slice of state and then select all the todo objects later using that key thing yeah I guess you have to do it this way
// because everyting is namespaced by a 1

/* so state looks like this
  state = {
    todos: {
      1: {},
      2: {},
      3: {]}
    }
  }
*/

// so you could do Object.values(state.todos) no right if you can do it for keys and that would get you the 1, 2, 3 you should be able to just do values right