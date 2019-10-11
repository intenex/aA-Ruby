import { connect } from 'react-redux';
import StepList from './step_list';
import { receiveStep } from './../../actions/todo_actions';
import { stepsByTodoId } from './../../reducers/selectors';

const mapStateToProps = (state, ownProps) => ({
  steps: stepsByTodoId(ownProps.todoId),
  todo_id: ownProps.todoId
});

const mapDispatchToProps = dispatch => ({
  receiveStep: step => dispatch(receiveStep(step))
});

export default connect(mapStateToProps, mapDispatchToProps)(StepList);