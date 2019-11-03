import React from 'react';
import { Homepage } from '../Pages/Homepage';
import { Downloader } from '../Pages/Downloader';
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
          <Route exact path="/uploads" component={Homepage} />
          <Route exact path="/downloader" component={Downloader}/>
        </Switch>
      </Router>
    );
  };

export default RoutesContainer;