import React from 'react';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      // something will go here later lol
    };
  }

  addTodo(event) {
    console.log(event);
  }

  render() { // oh fuck yeah this is exactly as far as you got with your code let's make new changes now :)
    return (
      <form onSubmit={this.addTodo}>
        <label>Todo:
          <input type="text" name="todo" />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}

export default TodoForm;