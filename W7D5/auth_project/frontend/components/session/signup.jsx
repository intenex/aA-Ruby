import React from 'react';

export default class Signup extends React.Component {  
  constructor(props) {
    super(props);
    this.state = {
      username: '',
      email: '',
      password: ''
    };
    this.handleInput = this.handleInput.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
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
      <div className="session-form">
        <h2>Sign Up!</h2>
        <form onSubmit={this.handleSubmit}>
          <label>Username:
            <input type="text" value={this.state.username} onChange={this.handleInput("username")} />
          </label>
          <label>Email:
            <input type="text" value={this.state.email} onChange={this.handleInput("email")} />
          </label>
          <label>Username:
            <input type="password" value={this.state.password} onChange={this.handleInput("password")} />
          </label>
          <input type="submit" value="Sign up!" />
        </form>
      </div>
    );
  }
};