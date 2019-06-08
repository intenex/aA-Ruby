import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.handleRemove = this.handleRemove.bind(this);
  }

  handleRemove(event) {
    event.preventDefault(); // don't think there is a default for buttons but why not
    this.props.removeTodo(this.props.todo);
  }

  render() {
    return (
      <li>
        <div>
          <h3>{this.props.todo.title}</h3>
          <button onClick={this.handleRemove}>Delete Todo</button>
          <button>Done</button>
        </div>
      </li>
    );
  }

}
export default TodoListItem;