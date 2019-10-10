import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.updateTodo = this.updateTodo.bind(this);
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
      <li>{todo.title} -- <button onClick={this.updateTodo}>{doneState}</button></li>
    );
  }
}

export default TodoListItem;