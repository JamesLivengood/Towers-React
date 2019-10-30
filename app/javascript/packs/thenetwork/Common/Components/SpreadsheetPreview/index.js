import React from 'react';
var SpreadsheetPreview = function (_a) {
    var data = _a.data;
    var table = function () {
        if (data.length === 0)
            return null;
        var headers = [];
        data[0].forEach(function (key, idx) {
            headers.push(React.createElement("p", { key: idx }, key));
        });
        return headers;
    };
    return (React.createElement("div", null, table()));
};
export default SpreadsheetPreview;
//# sourceMappingURL=index.js.map