import React from 'react';
import { Homepage } from '../Pages/Homepage';
import { Unsubscribe } from '../Pages/Unsubscribe';
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
          <Route exact path="/unsubscribe/:contactId/:unsubscribeKey" component={Unsubscribe} />
          <Redirect from="/" to="/" />
        </Switch>
      </Router>
    );
  };
  
  export default RoutesContainer;