import React from 'react';
import Header from './header';

class Tabs extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tabIndex: 0
    };
    this.changeTabIndex = this.changeTabIndex.bind(this);
    // this.props.array[0].content, this.props.array[0].title
    // this.props.array[tabIndex].content
  }

  changeTabIndex(event) {
    const currentIdx = event.currentTarget.id;
    this.setState({tabIndex: currentIdx});
  }

  render() {
    const tabs = this.props.tabs;
    const currentTab = this.state.tabIndex;
    return (
      <section class="tab-container">
        <ul class="tabs">
          {tabs.map((el, idx) => <Header callback={this.changeTabIndex} key={idx} idx={idx} title={el.title} />)}
        </ul>
        <article>{tabs[currentTab].content}</article>
      </section>

    );
  }
}

export default Tabs;