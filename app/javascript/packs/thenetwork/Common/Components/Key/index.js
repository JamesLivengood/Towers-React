import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faCoffee } from '@fortawesome/free-solid-svg-icons';
var Key = function () {
    return (React.createElement("span", { className: "key" },
        React.createElement(FontAwesomeIcon, { icon: faCoffee }),
        React.createElement("div", { className: "mb-10x flex align-center" },
            React.createElement("img", { className: "h-20x mr-3x", src: "http://maps.google.com/mapfiles/ms/icons/red-dot.png" }),
            React.createElement("span", null, "Tower")),
        React.createElement("div", { className: "mb-10x flex align-center" },
            React.createElement("img", { className: "h-20x mr-3x", src: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png" }),
            React.createElement("span", null, "Single Antenna")),
        React.createElement("div", { className: "flex align-center" },
            React.createElement("img", { className: "h-20x mr-3x", src: "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png" }),
            React.createElement("span", null, "Multiple Antennas"))));
};
export default Key;
//# sourceMappingURL=index.js.map