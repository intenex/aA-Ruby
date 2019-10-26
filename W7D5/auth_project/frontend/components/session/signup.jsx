import React from 'react';

export default class Signup extends React.Component {  
  constructor(props) {
    super(props);
    this.state = {
      username: '',
      email: '',
      password: ''
    };
  }
  render() {
    return (
      <div className="session-form"></div>
    );
  }
};