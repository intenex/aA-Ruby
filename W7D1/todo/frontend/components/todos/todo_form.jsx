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
  }

  updateTitle(event) {
    event.preventDefault();
    this.setState({title: event.currentTarget.value}); // passed an object that it merges with existing state love it
  }

  updateBody(event) {
    event.preventDefault();
    this.setState({body: event.currentTarget.value});
  }

  render() {
    const receiveTodo = this.props.receiveTodo;
    const formattedTodo = {
      title: this.state.title,
      body: this.state.body
    };
    return(
      <div>
        <label>Title:
          <input onChange={this.updateTitle} value={this.state.word}/>
        </label>
        <label>Body:
          <input onChange={this.updateBody} value={this.state.body}/>
        </label>
        <button onClick={receiveTodo(formattedTodo)}>Create Todo!</button>
      </div>
    )
  }
}

export default TodoList;