// selectors are getter functions for the application state --> they get specific slices of the state in some specific desired output format

export function allTodos(state) { // dope works flawlessly really grokking it now so lucky
  return Object.values(state.todos); // kind of impressive you did this with map but what the fuck lmao how were you writing code like this wtf glad to know you've actually leveled up in JS but also nuts that you were doing this though it's honestly impressive you could use .map like that didn't even know .map was a JS function anymore have to do way more code love this shit so much man
}

// oh thank god it's not your fucking idiocy somehow their fucking instructions
// tell you to do that unbelievable shit thank god okay so you're not so bad at
// coding lmao they somehow wanted you to do it that way wtf

/* 
Use Object.keys(state.todos) to get the keys for the state.todos.
Map the array of todo ids to an array of todos.
Return your new array.
*/

// God damn it the answer is it's ES5 syntax and crazy out of date sigh