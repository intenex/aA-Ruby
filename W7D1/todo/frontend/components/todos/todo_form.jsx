import React from 'react';
import { uniqueId } from './../util.js';

class TodoList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      title: '',
      body: ''
    };
    this.updateTitle = this.updateTitle.bind(this); // binding creates a scope even when invoked as a callback - how does it do this? Interesting
    this.updateBody = this.updateBody.bind(this);
    this.createTodo = this.createTodo.bind(this);
  }

  updateTitle(event) {
    event.preventDefault();
    this.setState({title: event.currentTarget.value}); // passed an object that it merges with existing state love it
  }

  updateBody(event) {
    event.preventDefault();
    this.setState({body: event.currentTarget.value});
  }

  createTodo(event) {
    event.preventDefault();
    const formattedTodo = {
      id: uniqueId(),
      title: this.state.title,
      body: this.state.body,
      done: false
    };
    this.props.receiveTodo(formattedTodo);
  }

  render() {
    return(
      <div>
        <label>Title:
          <input onChange={this.updateTitle} value={this.state.word}/>
        </label>
        <label>Body:
          <input onChange={this.updateBody} value={this.state.body}/>
        </label>
        <button onClick={this.createTodo}>Create Todo!</button>
      </div>
    )
  }
}

export default TodoList;