import React from 'react';
import { PageWithHeader } from '../../Common/Components/PageWithHeader';
import SpreadsheetUploader from '../../Common/Components/SpreadsheetUploader';
var Homepage = function (props) {
    return (React.createElement(PageWithHeader, { header: "Towers" },
        React.createElement("p", null, "Upload tower sites:"),
        React.createElement(SpreadsheetUploader, null)));
};
export { Homepage };
//# sourceMappingURL=index.js.map