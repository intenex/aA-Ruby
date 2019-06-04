import { connect } from 'react-redux';
import TodoList from './todo_list';
import { allTodos } from '../../reducers/selectors';

// container components do actually all the hard work of the logic behind the scenes

const mapStateToProps = (state, ownProps) => ({ // implicit object return fat arrow function dope // right love it as long as no brackets around it so great
  todos: allTodos(state) // awesome using the selector here dope
});

const mapDispatchToProps = (dispatch) => ({
  receiveTodo: todo => dispatch(receiveTodo(todo)) // look more into how this thing has access to the receiveTodo function just globally like this think through it a little bit later for sure. A lot to think through and work with for sure right now man definitely do it all.
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);

// lol they literally keep telling you the answers but you keep doing it just fine on your own dope