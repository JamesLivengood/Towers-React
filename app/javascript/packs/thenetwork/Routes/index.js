import React from 'react';
import TowerMap from '../Pages/TowerMap';
import { Route, Switch, BrowserRouter as Router } from 'react-router-dom';
var RoutesContainer = function () {
    return (React.createElement(Router, null,
        React.createElement(Switch, null,
            React.createElement(Route, { exact: true, path: "/", component: TowerMap }),
            React.createElement(Route, { exact: true, path: "/downloads-map", render: function (props) { return React.createElement(TowerMap, { downloads: true }); } }))));
};
export default RoutesContainer;
//# sourceMappingURL=index.js.map