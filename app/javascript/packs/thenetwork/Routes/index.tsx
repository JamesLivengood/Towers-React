import React from 'react';
import TowerMap from '../Pages/TowerMap';

import {
    Route,
    Redirect,
    Switch,
    BrowserRouter as Router
} from 'react-router-dom';

const RoutesContainer = () => {
    return (
      <Router>
        <Switch>
          <Route exact path="/" component={TowerMap} />
          <Route exact path="/downloads-map" render={(props) => <TowerMap downloads={true}/>}/>
        </Switch>
      </Router>
    );
  };

export default RoutesContainer;