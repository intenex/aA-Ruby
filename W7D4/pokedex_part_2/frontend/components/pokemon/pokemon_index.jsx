import React from 'react';
import PokemonIndexItem from './pokemon_index_item';

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
      <PokemonIndexItem key={idx} pokemon={pokemon} />
      );
    });
    return(
      <section className="pokedex">
        <ul>
          {pokemonList}
        </ul>
      </section>
    );
  }
}