import React from 'react';
import { Homepage } from '../Pages/Homepage';

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
          <Route exact path="/" component={Homepage} />
        </Switch>
      </Router>
    );
  };

  export default RoutesContainer;