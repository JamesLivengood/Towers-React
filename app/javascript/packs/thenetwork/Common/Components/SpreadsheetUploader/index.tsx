import React, { FC } from 'react';
import { CSVReader } from 'react-papaparse';

type IProps = {
};

const SpreadsheetUploader: FC<IProps> = (props) => {
  const [fileInput, setFileInput] = React.useState(null)

  const handleReadCSV = (data) => {
    console.log(data);
  }

  const handleOnError = (err, file, inputElem, reason) => {
    console.log(err);
  }

  const handleImportOffer = () => {
    fileInput.current.click();
  }

  return (
    <CSVReader
      onFileLoaded={handleReadCSV}
      inputRef={fileInput}
      onError={handleOnError}
    />
  )
}

export default SpreadsheetUploader;