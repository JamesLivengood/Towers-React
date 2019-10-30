import React from 'react';
import { Homepage } from '../Pages/Homepage';
import TowerMap from '../Pages/TowerMap';
import { Route, Switch, BrowserRouter as Router } from 'react-router-dom';
var RoutesContainer = function () {
    return (React.createElement(Router, null,
        React.createElement(Switch, null,
            React.createElement(Route, { exact: true, path: "/", component: TowerMap }),
            React.createElement(Route, { exact: true, path: "/uploads", component: Homepage }))));
};
export default RoutesContainer;
//# sourceMappingURL=index.js.map