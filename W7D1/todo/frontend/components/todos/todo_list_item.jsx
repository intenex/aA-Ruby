import React from 'react';
import TodoDetailViewContainer from './todo_detail_view_container';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      detail: false
    };
    this.updateTodo = this.updateTodo.bind(this);
    this.showDetails = this.showDetails.bind(this);
  }

  updateTodo(event) {
    event.preventDefault();
    let { todo, receiveTodo } = this.props;
    todo.done = !todo.done;
    receiveTodo(todo);
  }

  showDetails(event) {
    event.preventDefault();
    this.setState({detail: !this.state.detail}); // swap the state
  }

  render() {
    let { todo } = this.props;
    let doneState = "Done";
    if (todo.done) { doneState = "Undo"; }
    return(
      <div>
        <li>{todo.title} -- <button onClick={this.updateTodo}>{doneState}</button> -- <button onClick={this.showDetails}>Show Details</button></li>
        {this.state.detail && <TodoDetailViewContainer todo={todo}/>}
      </div>
    );
  }
}

// note {this.state.detail && <TodoDetailViewContainer />} works because if the first
// statement evaluates to true the entire thing will evaluate to the value of the second thing passed after &&
// and if the first statement is false it'll evaluate to just false and not do anything brilliant
// from https://reactjs.org/docs/conditional-rendering.html
// remember to try the ternary operator too later like so {this.state.detail ? <TodoDetailViewContainer /> : <div></div>} see if you can just put nothing after the : or maybe just write false or something instead of <div></div> pretty sure you can hmm

export default TodoListItem;