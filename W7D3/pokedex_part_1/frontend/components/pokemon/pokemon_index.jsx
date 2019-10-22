import React from 'react';

export default class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      {this.props.pokemon.map((pokemon, idx) => <li key={idx}>
        <p>{pokemon.name}</p><br/>
        <img src={pokemon.image_url} />
      </li>)}
    );
  }
}