import React, { FC } from 'react';

type IProps = {
  data: Array<Array<String>>
};

const SpreadsheetPreview: FC<IProps> = ({ data }) => {
  const table = () => {
    if (data.length === 0) return null;

    let headers = []
    data[0].forEach((key, idx) => {
      headers.push(<p key={idx}>{key}</p>);
    });
    return headers;
  }

  return (
    <div>
      {table()}
    </div>
  )
}

export default SpreadsheetPreview;