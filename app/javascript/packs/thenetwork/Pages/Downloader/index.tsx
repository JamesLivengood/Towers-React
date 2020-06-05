import React, { FC } from 'react';
import axios from 'axios';
// import antennaSearchDownloader from '../../Utils/antennaSearchDownloader';

const Downloader: FC = (props) => {
  const [form, setForm] = React.useState({
    lat: 0, lng: 0, height: 0, width: 0
  });

  const handleChange = () => {
    let element = event.target as HTMLInputElement;
    setForm((form) => {
      return {
        ...form,
        [element.name]: element.value
      }
    })
  }

  const handleSubmit = () => {
    axios.post(
      `/api/antenna_search_urls`,
      { antenna_search_urls: form },
      { headers: { 'Content-Type': 'application/json' } }
    ).catch(error => {
        console.log(error);
      });
  }

  return (
    <div>
      <label>Lat: </label>
      <input name="lat" type="number" onChange={handleChange}></input>
      <label>Lng: </label>
      <input name="lng" type="number" onChange={handleChange}></input>
      <label>Height (miles): </label>
      <input name="height" type="number" onChange={handleChange}></input>
      <label>Width (miles): </label>
      <input name="width" type="number" onChange={handleChange}></input>

      <button type="submit" onClick={handleSubmit}>Submit</button>
    </div>
  );
};

export { Downloader };