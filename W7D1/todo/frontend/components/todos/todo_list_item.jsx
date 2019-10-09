import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    let { todo, removeTodo } = this.props;
    return(
      <li>{todo.title}</li>
    );
  }
}

export default TodoListItem;