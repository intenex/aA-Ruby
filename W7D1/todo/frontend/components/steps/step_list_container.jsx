import { connect } from 'react-redux';
import StepList from './step_list';
import { receiveStep } from './../../actions/todo_actions';
import { stepsByTodoId } from './../../reducers/steps_reducer';

const mapStateToProps = (state, todoId) => ({
  steps: stepsByTodoId(todoId),
  todo_id: todoId
});

const mapDispatchToProps = dispatch => ({
  receiveStep: step => dispatch(receiveStep(step))
});

export default connect(mapStateToProps, mapDispatchToProps)(StepList);