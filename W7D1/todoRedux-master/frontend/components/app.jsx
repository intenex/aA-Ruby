import React from 'react';
import TodoListContainer from './todos/todo_list_container'; // arbitrarily named

class App extends React.Component {
  // constructor(props){
  //   super(props);
  // }

  render() {
    return (
      <TodoListContainer />
    );
  }
}

export default App;