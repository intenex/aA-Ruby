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
  }

  updateTitle(event) {

  }

  updateBody(event) {

  }

  render() {
    return(
      <form>
        
      </form>
    );
  }
}

export default StepForm;