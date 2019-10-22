import React from 'react';
import { Provider } from 'react-redux';

const Root = ({store}) => ( // from props get the store specifically love it right you get passed a props object just destructure what attributes you want great
  <Provider store={store}>
    <h1>Hello!</h1>
  </Provider>
);

export default Root;