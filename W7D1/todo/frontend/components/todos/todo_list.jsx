import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

export default ({todos, receiveTodo}) => (
  <ul>
    {todos.map((todo, idx) => (<TodoListItem todo={todo} key={idx} />))}
    <TodoForm receiveTodo={receiveTodo}/>
  </ul>
);