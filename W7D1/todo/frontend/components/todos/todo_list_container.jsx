import { connect } from 'react-redux';
import TodoList from './todo_list';
import { allTodos } from './../../reducers/selectors';
import { receiveTodo } from './../../actions/todo_actions';

const mapStateToProps = state => ({ // right this returns an object with all the props yep makes sense
  todos: allTodos(state)
});

const mapDispatchToProps = dispatch => ({
  receiveTodo: todo => dispatch(receiveTodo(todo)) // omg yes because you removed it elsewhere it finally isn't here when bundle was rebuilt from scratch that makes sense thank god whew
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);