import React from 'react';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      // something will go here later lol
    };
  }

  render() { // oh fuck yeah this is exactly as far as you got with your code let's make new changes now :)
    return (
      <form>
        <label>Todo:
          <input type="text" name="todo"></input>
        </label>
      </form>
    );
  }
}

export default TodoForm;