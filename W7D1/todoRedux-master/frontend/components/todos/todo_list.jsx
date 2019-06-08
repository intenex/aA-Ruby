import TodoListItem from '../todo_list/todo_list_item'; // holy shit automatic updating jesus christ that's amazing
import TodoForm from './../todo_list/todo_form';

// right presentational components are just components that just do the html and stuff

// damn can't believe this works so well amazing lol
// this gets passed a props object with a key todos that you can object deconstruct out so lucky to understand that and really get it all
// yep this gets all the todos and then you map them to return all the todo list item <li>s so great that map is indeed very impressive lol
// any JS code goes within the {} brackets then it seems great to know it weird though because that map should return an array but somehow ti works hmm look into it more
const TodoList = ({todos, receiveTodo}) => ( // ah right okay perfect the parentheses work fantastic here for jsx still not clear exactly how that syntactic sugar works right it has to do with the extension of this file name it must read in the jsx first and parse that first before making it all JS love it
  <ul>
    {todos.map(todo => <TodoListItem todo={todo} />)}
    <TodoForm />
  </ul>
);

export default TodoList;

// fucking love it works flawlessly dope