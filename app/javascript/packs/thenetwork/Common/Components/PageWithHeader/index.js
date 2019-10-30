import React from 'react';
var PageWithHeader = function (props) {
    var header = props.header, children = props.children;
    return (React.createElement("div", { className: "container" },
        React.createElement("div", { className: "row justify-content-center" },
            React.createElement("div", { className: "col-lg-8 col-md-10 col-sm-12" },
                React.createElement("article", { className: "post" },
                    React.createElement("header", { className: "post-header" },
                        React.createElement("h1", { className: "post-title" }, header)),
                    React.createElement("div", { className: "post-content" }, children)),
                React.createElement("p", null,
                    React.createElement("small", null,
                        "\u00A9 2019, ",
                        React.createElement("a", { href: 'mailto:muceybabi@gmail.com' }, "Email me")))))));
};
export { PageWithHeader };
//# sourceMappingURL=index.js.map