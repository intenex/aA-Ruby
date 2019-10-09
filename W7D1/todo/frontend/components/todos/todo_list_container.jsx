import { connect } from 'react-redux';
import TodoList from './todo_list';
import { allTodos } from './../reducers/selectors';

const mapStateToProps = state => ({ // right this returns an object with all the props yep makes sense
  todos: allTodos(state)
});

const mapDispatchToProps = dispatch => ({
  receiveTodo: todo => dispatch(receiveTodo(todo))
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);