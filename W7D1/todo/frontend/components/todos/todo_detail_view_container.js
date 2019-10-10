import { connect } from 'react-redux';
import TodoDetailView from './todo_detail_view';
import { removeTodo, receiveSteps } from './../../actions/todo_actions';

const mapDispatchToProps = dispatch => ({ // right these are functions that return objects that have keys that become props love it
  removeTodo: todo => dispatch(removeTodo(todo)),
  receiveSteps: steps => dispatch(receiveSteps(steps))
});

export default connect(null, mapDispatchToProps)(TodoDetailView);