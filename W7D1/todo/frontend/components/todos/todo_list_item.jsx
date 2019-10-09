import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.deleteTodo.bind(this);
    this.updateTodo.bind(this);
  }

  deleteTodo(event) {
    event.preventDefault();
    let { todo, removeTodo } = this.props;
    removeTodo(todo);
  }

  updateTodo(event) {
    event.preventDefault();
    let { todo, receiveTodo } = this.props;
    todo.done = !todo.done;
    receiveTodo(todo);
  }

  render() {
    let { todo } = this.props;
    let doneState = "Done";
    if (todo.done) { doneState = "Undo"; }
    return(
      <li>{todo.title} -- <button onClick={this.updateTodo}>{doneState}</button> -- <button onClick={this.deleteTodo}>Delete Todo!</button></li>
    );
  }
}

export default TodoListItem;