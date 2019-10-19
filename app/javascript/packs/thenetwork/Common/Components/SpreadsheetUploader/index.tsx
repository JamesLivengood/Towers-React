import React, { FC } from 'react';
import { CSVReader } from 'react-papaparse';

type IProps = {
};

const SpreadsheetUploader: FC<IProps> = (props) => {
  // const upload = (evt) => {
    // var selectedFile = evt.target.files[0];
    // var reader = new FileReader();
    // reader.onload = function (event) {
    //   var data = event.target.result;
    //   var workbook = XLSX.read(data, {
    //     type: 'binary'
    //   });
    //   workbook.SheetNames.forEach(function (sheetName) {
    //     debugger
    //     // var XL_row_object = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
    //     // var json_object = JSON.stringify(XL_row_object);
    //     // document.getElementById("jsonObject").innerHTML = json_object;

    //   })
    // };

    // reader.onerror = function (event) {
    //   console.error("File could not be read! Code " + event.target.error.code);
    // };

    // reader.readAsBinaryString(selectedFile);
  // };

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
    // <input type="file" id="fileUploader" name="fileUploader" onChange={upload}/>
    <CSVReader
      onFileLoaded={handleReadCSV}
      inputRef={fileInput}
      // style={{ display: 'none' }}
      onError={handleOnError}
    />
  )
}

export default SpreadsheetUploader;