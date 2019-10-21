import React, { FC } from 'react';
import { CSVReader } from 'react-papaparse';
// import SpreadsheetPreview from '../SpreadsheetPreview';
import axios from 'axios';

type IProps = {
};

const SpreadsheetUploader: FC<IProps> = (props) => {
  const [fileInput, setFileInput] = React.useState(null);
  const [data, setData] = React.useState([]);

  const handleReadCSV = (data) => {
    setData(data.data);

    const paramKey = data.data[0].includes('sitetype') ? 'transmitters' : 'towers';

    axios.post(
      `/api/${paramKey}`,
      { [paramKey]: parseData(data.data) },
      { headers: { 'Content-Type': 'application/json' } }
    ).then(res => console.log(res))
     .then(res => console.log(res))
     .catch(error =>{
       console.log(error);
     });
  }

  const parseData = (arr) => {
    const headers = arr[0];
    const convertedArr = [];

    arr.slice(1).forEach(dataSubject => {
      const object = {};

      headers.forEach((header, idx) => {
        object[header] = dataSubject[idx];
      });
      convertedArr.push(object);
    });
    return convertedArr;
  }

  const handleOnError = (err, file, inputElem, reason) => {
    console.log(err);
  }

  const handleImportOffer = () => {
    fileInput.current.click();
  }

  return (
    <div>
      <CSVReader
        onFileLoaded={handleReadCSV}
        // inputRef={fileInput}
        onError={handleOnError}
      />
      {/* <SpreadsheetPreview data={data}/> */}
    </div>
    )
  }

export default SpreadsheetUploader;