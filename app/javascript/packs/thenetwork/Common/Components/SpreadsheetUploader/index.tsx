import React, { FC } from 'react';
import { CSVReader } from 'react-papaparse';
import SpreadsheetPreview from '../SpreadsheetPreview';
import axios from 'axios';

type IProps = {
};

const SpreadsheetUploader: FC<IProps> = (props) => {
  const [fileInput, setFileInput] = React.useState(null);
  const [data, setData] = React.useState([]);

  const handleReadCSV = (data) => {
    // console.log(data);
    setData(data.data);
    axios.post(
      '/api/towers',
      { towers: data.data },
      { headers: { 'Content-Type': 'application/json' } }
    ).then(res => console.log(res))
     .catch(error =>{
       debugger;
     });
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
      <SpreadsheetPreview data={data}/>
    </div>
    )
  }

export default SpreadsheetUploader;