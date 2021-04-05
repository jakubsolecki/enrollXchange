import React, { Component } from "react";
import { render } from "react-dom";
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import Home from "./Home";
import MySchedule from "./MySchedule";

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      data: [],
      loaded: false,
      placeholder: "Loading"
    };
  }

  render() {
    return (
        <Router>
          <Switch>
              <Route exact path='/' component={Home} />
              <Route path='/my-schedule' component={MySchedule} />
          </Switch>
        </Router>
    );
  }
}

export default App;

const container = document.getElementById("app");
render(<App />, container);
