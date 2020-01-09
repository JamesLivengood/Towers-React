import React from 'react';
import { Homepage } from '../Pages/Homepage';
import { Downloader } from '../Pages/Downloader';
import TowerMap from '../Pages/TowerMap';
import { Route, Switch, BrowserRouter as Router } from 'react-router-dom';
var RoutesContainer = function () {
    return (React.createElement(Router, null,
        React.createElement(Switch, null,
            React.createElement(Route, { exact: true, path: "/", component: TowerMap }),
            React.createElement(Route, { exact: true, path: "/downloads-map", render: function (props) { return React.createElement(TowerMap, { downloads: true }); } }),
            React.createElement(Route, { exact: true, path: "/uploads", component: Homepage }),
            React.createElement(Route, { exact: true, path: "/downloader", component: Downloader }))));
};
export default RoutesContainer;
//# sourceMappingURL=index.js.map