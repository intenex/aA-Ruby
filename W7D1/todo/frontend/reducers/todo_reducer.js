const initialState = { // note this is just for the todo slice of state as all the reducers are combined by the root reducer love it
  1: {
    id: 1,
    title: "wash car",
    body: "with soap",
    done: false
  },
  2: {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  }
};

const todosReducer = (state = initialState, action) => {
  switch (action.type) {
    default:
      return state;
  }
};

export default todosReducer;