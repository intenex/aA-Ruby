import React from 'react';
import StepListContainer from './../steps/step_list_container';

class TodoDetailView extends React.Component {
  constructor(props) {
    super(props);
    this.deleteTodo = this.deleteTodo.bind(this);
  }

  deleteTodo(event) {
    event.preventDefault();
    let { todo, removeTodo, fUpdate } = this.props;
    removeTodo(todo);
    fUpdate(); // force rerendering the list see if that works
  }
  
  render() {
    const { id, body } = this.props.todo;
    return(
      <div>
        <div>ID: {id}</div><br />
        <div>{body}</div><br />
        <button onClick={this.deleteTodo}>Delete Todo!</button>
        <br /><br />
        <StepListContainer todo={this.props.todo}/>
      </div>
    );
  }
}

export default TodoDetailView;