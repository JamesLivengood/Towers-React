import React from 'react';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTimes, faPlus, faMinus } from '@fortawesome/free-solid-svg-icons';
var Key = function (_a) {
    var adjustMarkerSizeMultiplier = _a.adjustMarkerSizeMultiplier;
    var hideKey = function () {
        document.getElementsByClassName("key")[0].classList.add("hidden");
    };
    return (React.createElement("span", { className: "key" },
        React.createElement(FontAwesomeIcon, { icon: faTimes, className: "x", onClick: hideKey }),
        React.createElement("div", { className: "mb-10x flex align-center" },
            React.createElement("img", { className: "h-20x mr-3x", src: "http://maps.google.com/mapfiles/ms/icons/red-dot.png" }),
            React.createElement("span", null, "Tower")),
        React.createElement("div", { className: "mb-10x flex align-center" },
            React.createElement("img", { className: "h-20x mr-3x", src: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png" }),
            React.createElement("span", null, "Single Antenna")),
        React.createElement("div", { className: "mb-10x flex align-center" },
            React.createElement("img", { className: "h-20x mr-3x", src: "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png" }),
            React.createElement("span", null, "Multiple Antennas")),
        React.createElement("div", { className: "mb-10x flex align-center" },
            React.createElement("img", { className: "h-20x mr-3x", src: "http://maps.google.com/mapfiles/ms/icons/green-dot.png" }),
            React.createElement("span", null, "Searched Location")),
        React.createElement("div", { className: "flex justify-center marker-size-adjuster" },
            React.createElement("span", { className: "round-left" },
                React.createElement(FontAwesomeIcon, { icon: faMinus, className: "decrease-size", onClick: adjustMarkerSizeMultiplier })),
            React.createElement("span", { className: "round-right" },
                React.createElement(FontAwesomeIcon, { icon: faPlus, className: "increase-size", onClick: adjustMarkerSizeMultiplier })))));
};
export default Key;
//# sourceMappingURL=index.js.map