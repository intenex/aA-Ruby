import React from 'react';

class StepListItem extends React.Component {
  constructor(props) {
    super(props);
    this.deleteStep = this.deleteStep.bind(this);
    this.updateStep = this.updateStep.bind(this);
  }

  deleteStep(event) {
    event.preventDefault();
    this.props.removeStep(this.props.step);
  }

  updateStep(event) {
    event.preventDefault();
    const step = this.props.step;
    step.done = !step.done;
    this.props.receiveStep(step);
  }

  render() {
    const { step } = this.props;
    let doneState = "Done";
    if (step.done) {
      doneState = "Undo";
    }
    return(
      <div>
        <h3>{step.title}</h3><br/>
        <p>{step.body}</p><br/>
        <button onClick={this.updateStep}>{doneState}</button> -- <button onClick={this.deleteStep}>Delete step!</button>
      </div>
    );
  }
}

export default StepListItem;