import React from 'react';
import { Provider } from 'react-redux';
import App from './app';

// class Root extends React.Component {
//   constructor(props){
//     super(props); // as always unnecessary if this is all it's doing
//   }

//   // right so much to remember keep practicing React to really get it you have to wrap the store with {Store} love it keep pushing for sure you have to interpolate like that in JSX so great

//   render() { // ah right React gives you the option to close the tags self closing or not self closing as is needed brilliant love it right of course
//     return(
//       <Provider store={this.props.store}>
//         <App />
//         <h1>{this.props.store}</h1>
//       </Provider>
//     );
//   }
// }

// functional component style
const Root = ({store}) => ( // god damn it you needed to return explicitly sigh
  <Provider store={store}>
    <App />
  </Provider>
);

export default Root;