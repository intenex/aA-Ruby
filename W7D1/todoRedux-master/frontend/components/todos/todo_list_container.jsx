import { connect } from 'react-redux';
import TodoList from './todo_list';
import { allTodos } from '../../reducers/selectors';

const mapStateToProps = (state, ownProps) => ({ // implicit object return fat arrow function dope
  todos: allTodos(state)
});

const mapDispatchToProps = (dispatch) => ({
  receiveTodo: todo => dispatch(receiveTodo(todo))
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);

// lol they literally keep telling you the answers but you keep doing it just fine on your own dope