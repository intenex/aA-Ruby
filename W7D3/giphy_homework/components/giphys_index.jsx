import React from 'react';

import GiphysIndexItem from './giphys_index_item';

const GiphysIndex = ({giphys}) => (
  <ul>
    {giphys.map((giphy, idx) => <GiphysIndexItem giphy={giphy} key={idx} />)}
  </ul>
);