import React from 'react';
import ReactDOM from 'react-dom';

document.addEventListener('DOMContentLoaded', () => { // document.addEventListener('DOMContentLoaded', callbackFunc) yep that's how to do it love it everything is on the document in vanillaDOM so great
  const root = document.getElementById('root');
  ReactDOM.render(<h1>Hi!</h1>, root);
});