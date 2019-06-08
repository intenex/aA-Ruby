import React from 'react';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      todo: ''
    };
    this.handleChange = this.handleChange.bind(this); // right have to bind this because it's going to be called function style by the component which is passed this as a callback uninvoked yep love it
    this.addTodo = this.addTodo.bind(this);
  }

  // basically whenever the text changes the state will change
  // and reflect the current todo value then you can use that
  // in the submit trigger
  // right it rerenders every time so you have to save it
  // as the new value love it heh
  // nope lol you fixed it now
  // so I suppose this is a controlled input
  handleChange(event) {
    console.log(event.target.value);
    this.setState({todo: event.target.value});
  }

  addTodo(event) {
    event.preventDefault(); // stop it from actually reloading the page
    console.log(this.state.todo);
  }

  render() { // oh fuck yeah this is exactly as far as you got with your code let's make new changes now :)
    return (
      <form onSubmit={this.addTodo}>
        <label>Todo:
          <input type="text"
            value={this.state.todo}
            onChange={this.handleChange} />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}

export default TodoForm;