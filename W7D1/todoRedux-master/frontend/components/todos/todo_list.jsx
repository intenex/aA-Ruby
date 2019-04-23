import TodoListItem from './todo_list_item';
import TodoForm from './../todo_list/todo_form';

// damn can't believe this works so well amazing lol
// this gets passed a props object with a key todos that you can object deconstruct out so lucky to understand that and really get it all
const TodoList = ({todos, receiveTodo}) => ( // ah right okay perfect the parentheses work fantastic here for jsx still not clear exactly how that syntactic sugar works right it has to do with the extension of this file name it must read in the jsx first and parse that first before making it all JS love it
  <ul>
    {todos.map(todo => <TodoListItem todo={todo} />)}
    <TodoForm />
  </ul>
);

export default TodoList;

// fucking love it works flawlessly dope