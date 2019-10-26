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

  handleInput(type) {
    return e => {
      this.setState({ [type]: e.target.value }); // square brackets mean it'll be evaluated before it sets the key brilliant, the variable will be evaluated so great
    };
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.createNewUser(this.state)
      .then(() => this.props.history.push('/chirps'));
  }

  render() {
    return (
      <div className="session-form"></div>
    );
  }
};