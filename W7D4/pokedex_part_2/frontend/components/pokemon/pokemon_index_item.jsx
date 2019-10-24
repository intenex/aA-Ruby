import React from 'react';
import { Link } from 'react-router-dom';

// right this isn't the thing that needs the index it's the thing above that does love that lol
const PokemonIndexItem = ({pokemon}) => (
  <li>
    <Link to="/pokemon/"{pokemon.id}>
      <p>{pokemon.name}</p><br />
      <img src={pokemon.image_url} />
    </Link>
  </li>
);

export default PokemonIndexItem;