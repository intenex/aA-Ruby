import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleRemove = this.handleRemove.bind(this);
    this.updateTodo = this.updateTodo.bind(this);
  }

  handleRemove(event) {
    event.preventDefault(); // don't think there is a default for buttons but why not
    this.props.removeTodo(this.props.todo);
  }

  updateTodo(event) {
    event.preventDefault();
    this.props.todo.done = !this.props.todo.done;
    this.props.receiveTodo(this.props.todo);
  }

  render() {
    return (
      <li>
        <div>
          <h3>{this.props.todo.title}</h3>
          <button onClick={this.handleRemove}>Delete Todo</button>
          <button onClick={this.updateTodo}>{this.props.todo.done ? "Done" : "Undo"}</button>
        </div>
      </li>
    );
  }

}
export default TodoListItem;