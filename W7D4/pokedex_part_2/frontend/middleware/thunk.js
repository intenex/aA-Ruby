// lol create your own thunk middleware dope

const thunk = ({dispatch, getState}) => next => action => { // it takes in dispatch next then action right yep ah yes it's passed the store love it yep right pass it dispatch and getState yep makes perf sense needs both to do something a little more critical thought would have figured that out if you can reason things out you 100% can figure them out way better than memorizing without understanding by a million times man
  if (typeof action === "function") {
    return action(dispatch, getState); // think through this thunk action creators create functions that modify state that are passed the dispatch function right so you should pass it the dispatch function right
  }
  return next(action);
};

export default thunk;