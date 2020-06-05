import React from 'react';
import { CSVReader } from 'react-papaparse';
// import SpreadsheetPreview from '../SpreadsheetPreview';
import axios from 'axios';
var SpreadsheetUploader = function (props) {
    var _a = React.useState(null), fileInput = _a[0], setFileInput = _a[1];
    var _b = React.useState([]), data = _b[0], setData = _b[1];
    var handleReadCSV = function (data) {
        var _a;
        setData(data.data);
        var paramKey = data.data[0].includes('sitetype') ? 'transmitters' : 'towers';
        axios.post("/api/" + paramKey, (_a = {}, _a[paramKey] = parseData(data.data), _a), { headers: { 'Content-Type': 'application/json' } }).catch(function (error) {
            console.log(error);
        });
    };
    var parseData = function (arr) {
        var headers = arr[0];
        var convertedArr = [];
        arr.slice(1).forEach(function (dataSubject) {
            var object = {};
            headers.forEach(function (header, idx) {
                object[header] = dataSubject[idx];
            });
            convertedArr.push(object);
        });
        return convertedArr;
    };
    var handleOnError = function (err, file, inputElem, reason) {
        console.log(err);
    };
    var handleImportOffer = function () {
        fileInput.current.click();
    };
    return (React.createElement("div", null,
        React.createElement(CSVReader, { onFileLoaded: handleReadCSV, 
            // inputRef={fileInput}
            onError: handleOnError })));
};
export default SpreadsheetUploader;
//# sourceMappingURL=index.js.map