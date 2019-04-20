import React from 'react';

class Weather extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      weather: 'Fetching Weather...'
    };
    this.posCallback = this.posCallback.bind(this);
  }

  componentDidMount() {
    navigator.geolocation.getCurrentPosition(this.posCallback, this.posError, {timeout: 10000});
  }

  posError(posErrorObj) {
    alert('error');
    console.log(posErrorObj);
  }

  // api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}
  posCallback(pos) {
    const coordinates = pos.coords;
    const long = coordinates.longitude;
    const lat = coordinates.latitude;
    const http = `http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&APPID=4b6730a7113a2cfdb61269cd7b0ec417`;
    let jsonCB = function(response) {
      return response.json();
    }
    let setWeather = function ({ main: { temp }, name }) {
      debugger;
      this.setState({ temp: (((parseInt(temp)-273) * 1.8) + 32), name });
    };
    setWeather = setWeather.bind(this);
    fetch(http).then(jsonCB).then(setWeather);
  }

  render() {
    return (
      <div>
        <p>{this.state.temp}ºF, {this.state.name}</p>
      </div>
    );
  }
}

export default Weather;