import React from 'react';

// right this isn't the thing that needs the index it's the thing above that does love that lol
const PokemonIndexItem = ({pokemon}) => (
  <li>
    <p>{pokemon.name}</p><br />
    <img src={pokemon.image_url} />
  </li>
);

export default PokemonIndexItem;