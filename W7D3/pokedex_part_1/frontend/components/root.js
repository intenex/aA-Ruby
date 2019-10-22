import React from 'react';
import { Provider } from 'react-redux';
import App from './app';

const root = ({store}) => ( // from props get the store specifically love it right you get passed a props object just destructure what attributes you want great
  <Provider store={store}>
    <App />
  </Provider>
);

export default root;