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
  }

  updateBody(event) {
    event.preventDefault();
  }

  render() {
    return(
      <h1>Hello</h1>
    )
  }
}

export default TodoList;