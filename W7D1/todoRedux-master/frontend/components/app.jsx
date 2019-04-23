import React from 'react';
import TodoListContainer from './todos/todo_list_container';

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