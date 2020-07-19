import React, { useEffect } from 'react';
var FoldingCube = function (_a) {
    var displayFoldingCube = _a.displayFoldingCube;
    useEffect(function () {
        var timer = setTimeout(function () {
            document.getElementsByClassName("page-slow-popup")[0].classList.remove("hidden");
        }, 10000);
        return function () { return clearTimeout(timer); };
    }, []);
    var hidePageSlowMessage = function () {
        document.getElementsByClassName("page-slow-popup")[0].classList.add("hidden");
    };
    return (React.createElement("div", { className: "loading-widget" },
        React.createElement("p", { className: "page-slow-popup hidden", onClick: hidePageSlowMessage }, "Page slow? Try zooming in a bit - too many markers slows down the map."),
        React.createElement("div", { className: "sk-folding-cube " + (displayFoldingCube ? '' : 'hidden') },
            React.createElement("div", { className: "sk-cube1 sk-cube" }),
            React.createElement("div", { className: "sk-cube2 sk-cube" }),
            React.createElement("div", { className: "sk-cube4 sk-cube" }),
            React.createElement("div", { className: "sk-cube3 sk-cube" }))));
};
export default FoldingCube;
//# sourceMappingURL=index.js.map