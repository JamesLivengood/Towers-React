import axios from 'axios';

export const fetchTowers = (setTowers): void => {
  axios.get(
    `/api/towers`
  ).then(res => {
    console.log(res);
    setTowers(res.data);
  })
    .catch(error => {
      console.warn(error);
    });
};

export const fetchTransmitters = (setTransmitters): void => {
  axios.get(
    `/api/transmitters`
  ).then(res => {
    console.log(res);
    setTransmitters(res.data);
  })
    .catch(error => {
      console.warn(error);
    });
};