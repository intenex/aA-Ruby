import { connect } from 'react-redux';
import TodoDetailView from './todo_detail_view';
import { removeTodo } from 

const mapDispatchToProps = dispatch => ({ // right these are functions that return objects that have keys that become props love it
  removeTodo: todo => dispatch(removeTodo(todo))
});

export default connect(null, mapDispatchToProps)(TodoDetailView);