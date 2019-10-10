import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {
  constructor(props) {
    super(props);
    this.fUpdate = this.fUpdate.bind(this);
  }

  fUpdate() {
    this.forceUpdate(); // damn this was not the issue
  }

  render() {
    const { todos, receiveTodo } = this.props;
    return(
      <ul>
        {todos.map((todo, idx) => (<TodoListItem todo={todo} key={idx} receiveTodo={receiveTodo} fUpdate={this.fUpdate}/>))}
        <br />
        <TodoForm receiveTodo={receiveTodo}/>
      </ul>
    );
  }
}

export default TodoList;