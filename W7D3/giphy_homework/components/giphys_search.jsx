import React from 'react';

import GiphysIndex from './giphys_index';

export default class GiphysSearch extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      searchTerm: "",
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(e) {
    // no default to prevent stop doing that lol
    this.setState({searchTerm: e.target.value});
  }

  handleSubmit(e) { // right this is by default clicked yeah dope hmm look into the solution afterwards yeah spend your time to really dig into and love learning things really cannot wait man life is going to be so great go through interviewcake with Mai and Dom afterwards that's key
    e.preventDefault();
    this.props.fetchSearchGiphys(this.state.searchTerm).then(() => { // right this must not be returning a promise yes that's the key love it yep good debugging
      this.setState({searchTerm: ""}); // somehow this works despite it not returning a promise almost certain maybe it does
    }); // reset the searchTerm and the key actually is not resetting the search term but re-rendering the component since now the global state giphys slice is actually active and has real giphys in it I think that's key love it but you have to reset the search term anyway so that's dope and specifically do it after the async thing returns love it
  }

  render() {
    return(
      <div>
        <form>
          <label>Search Term
            <input type="text" value={this.state.searchTerm} onChange={this.handleChange}/>
          </label>
          <input type="submit" value="Search for Giphys!" onClick={this.handleSubmit}/>
        </form>
        <GiphysIndex giphys={this.props.giphys} />
      </div>
    )
  }
}