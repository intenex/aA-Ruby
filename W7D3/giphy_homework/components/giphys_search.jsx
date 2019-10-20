import React from 'react';

import GiphysIndex from './giphys_index';

export default class GiphysSearch extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      searchTerm: ""
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(e) {
    // no default to prevent stop doing that lol
    this.setState({searchTerm: e.target.value});
  }

  handleSubmit(e) { // right this is by default clicked yeah dope hmm look into the solution afterwards yeah spend your time to really dig into and love learning things really cannot wait man life is going to be so great go through interviewcake with Mai and Dom afterwards that's key
    
  }

  render() {
    return(
      <form>
        <label>Search Term
          <input type="text" value={searchTerm} onClick={this.handleChange}/>
        </label>
        <input type="submit" value="Search for Giphys!" />
      </form>
    )
  }
}