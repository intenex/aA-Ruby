import React from 'react';
import TodoListItem from './todo_list_item';

export default ({todos, receiveTodo}) => (
  <ul>
    {todos.map((todo, idx) => (<TodoListItem key={idx} />))}
  </ul>
);