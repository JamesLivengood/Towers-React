var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
import React from 'react';
import axios from 'axios';
// import antennaSearchDownloader from '../../Utils/antennaSearchDownloader';
var Downloader = function (props) {
    var _a = React.useState({
        lat: 0, lng: 0, height: 0, width: 0
    }), form = _a[0], setForm = _a[1];
    var handleChange = function () {
        var element = event.target;
        setForm(function (form) {
            var _a;
            return __assign(__assign({}, form), (_a = {}, _a[element.name] = element.value, _a));
        });
    };
    var handleSubmit = function () {
        axios.post("/api/antenna_search_urls", { antenna_search_urls: form }, { headers: { 'Content-Type': 'application/json' } }).catch(function (error) {
            console.log(error);
        });
    };
    return (React.createElement("div", null,
        React.createElement("label", null, "Lat: "),
        React.createElement("input", { name: "lat", type: "number", onChange: handleChange }),
        React.createElement("label", null, "Lng: "),
        React.createElement("input", { name: "lng", type: "number", onChange: handleChange }),
        React.createElement("label", null, "Height (miles): "),
        React.createElement("input", { name: "height", type: "number", onChange: handleChange }),
        React.createElement("label", null, "Width (miles): "),
        React.createElement("input", { name: "width", type: "number", onChange: handleChange }),
        React.createElement("button", { type: "submit", onClick: handleSubmit }, "Submit")));
};
export { Downloader };
//# sourceMappingURL=index.js.map