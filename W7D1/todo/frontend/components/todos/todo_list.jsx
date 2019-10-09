import React from 'react';
import TodoListItem from './todo_list_item';

export default ({todos, receiveTodo}) => (
  <ul>
    {todos.map((todo, idx) => (<TodoListItem todo={todo} key={idx} />))}
  </ul>
);