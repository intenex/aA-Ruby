import { connect } from 'react-redux';
import TodoList from './todo_list';
import { allTodos } from './../reducers/selectors';

const mapStateToProps = state => ({ // right this returns an object with all the props yep makes sense
  todos: allTodos(state)
});

const mapDispatchToProps = dispatch => ({
  receiveTodo: todo => dispatch(receiveTodo(todo)) // figure out if you need to import the receiveTodo action creator or not and if not why not and if you need to import selectors etc. I think you don't because you imported it in the entry.jsx file in which this is ultimately called from so it's in some higher scope, but just test that later by seeing if that works or not if you remove it there
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);