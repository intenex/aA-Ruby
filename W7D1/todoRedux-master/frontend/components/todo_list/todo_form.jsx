import React from 'react';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: ''
    };
    this.handleChange = this.handleChange.bind(this); // right have to bind this because it's going to be called function style by the component which is passed this as a callback uninvoked yep love it
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  // basically whenever the text changes the state will change
  // and reflect the current todo value then you can use that
  // in the submit trigger
  handleChange(event) {
    this.setState({todo: event.target.value});
  }

  addTodo(event) {
    event.preventDefault(); // stop it from actually reloading the page
    console.log(event);
    console.log(event.target.value);
  }

  render() { // oh fuck yeah this is exactly as far as you got with your code let's make new changes now :)
    return (
      <form onSubmit={this.addTodo}>
        <label>Todo:
          <input type="text"
            value={this.state.value}
            onChange={this.handleChange} />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}

export default TodoForm;