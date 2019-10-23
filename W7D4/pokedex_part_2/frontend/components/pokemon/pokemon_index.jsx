import React from 'react';

export default class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestAllPokemon(); // update state with all the pokemon once the component mounts dope
  }

  // right you need to return one single parent component simple stupid man
  render() { // right works great because the json from the jbuilder views api returns the full image_url with the asset_path already so awesome man
    const { pokemon } = this.props;
    const pokemonList = pokemon.map((pokemon, idx) => {
      return(
      <li key={idx}>
        <p>{pokemon.name}</p><br/>
        <img src={pokemon.image_url} />
      </li>
      );
    });
    return(
      <ul>
        {pokemonList}
      </ul>
    );
  }
}