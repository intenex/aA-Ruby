import React from 'react';
import Tabs from './tabs';
import Clock from './clock';
import Weather from './weather';

class Root extends React.Component {
  constructor(props) {
    super(props);

  }

  render() {
    return (
      <div>
        <Clock />
        <Tabs tabs={[
          { title: 'Tab 1', content: 'Pane 1' },
          { title: 'Tab 2', content: 'Pane 2' },
          { title: 'Tab 3', content: 'Pane 3' }
        ]} />
        <Weather />
      </div>
    );
  }
}

export default Root;