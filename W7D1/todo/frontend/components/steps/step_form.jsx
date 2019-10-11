import React from 'react';
import { uniqueId } from './../util';

class StepForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      title: "",
      body: ""
    };
    this.updateTitle = this.updateTitle.bind(this);
    this.updateBody = this.updateBody.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  updateTitle(event) {
    event.preventDefault();
    const newTitle = event.currentTarget.value;
    this.setState({title: newTitle});
  }

  updateBody(event) {
    event.preventDefault();
    const newBody = event.currentTarget.value;
    this.setState({body: newBody});
  }

  handleSubmit(event) {
    event.preventDefault();
    const { receiveStep, todo } = this.props;
    const step = {
      id: uniqueId(),
      title: this.state.title,
      body: this.state.body,
      todo_id: todo.id,
      done: false
    };
    receiveStep(step);
    this.setState({title:"", body:""}); // reset the state
  }

  render() {
    return(
      <form>
        Title: <input onChange={this.updateTitle}></input>
        Details: <input onChange={this.updateBody}></input>
        <input type="submit" value="Submit" onClick={this.handleSubmit}></input>
      </form>
    );
  }
}

export default StepForm;