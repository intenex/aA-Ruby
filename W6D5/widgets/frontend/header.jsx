import React from 'react';

class Header extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <h1 onClick={this.props.callback} id={parseInt(this.props.idx)}>{this.props.title}</h1>
    );
  }
}

// const Header = ({title, idx, callback}) => {
//   return (
//     <h1 onClick={callback}>{title}</h1>
//   );
// };

export default Header;