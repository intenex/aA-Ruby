import React from 'react';
import { uniqueId } from '../../utils/util'; // right when not a single default import gets a single object of all the exports namespaced and you have to object deconstruct to get the ones you love love it

class TodoForm extends React.Component {
  constructor(props) {
    super(props); // recall what the React.Component does with props it just sets them to this.props right props=props? man rusty on your JS get back into it can't wait
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
    this.setState({todo: event.target.value});
  }

  // totally nuts this triggers a re-render without you doing anything else
  // remember how to get that to work but fuck yes
  addTodo(event) {
    event.preventDefault(); // stop it from actually reloading the page
    this.props.receiveTodo({ // this function calls dispatch again and passes it an action object which is created with the receiveTodo action creator which takes in this todo object here as a payload and puts it in a wrapper action object that also has a type to know what kind of action to take with it once it hits the reducer so fucking great totally fucking understand this code now fucking love life man
      id: uniqueId(), // get a unique ID
      title: this.state.todo,
      done: false
    });
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