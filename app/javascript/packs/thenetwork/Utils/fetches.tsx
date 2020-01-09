import axios from 'axios';

export const fetchTowers = (setTowers, bounds): void => {
  axios.get(
    `/api/towers?latmin=${bounds.pa.g}&latmax=${bounds.pa.h}&lngmin=${bounds.ka.h}&lngmax=${bounds.ka.g}`
  ).then(res => {
    setTowers(res.data);
  })
  .catch(error => {
    console.warn(error);
  });
};

export const fetchTransmitters = (setTransmitters, bounds): void => {
  axios.get(
    `/api/transmitters?latmin=${bounds.pa.g}&latmax=${bounds.pa.h}&lngmin=${bounds.ka.h}&lngmax=${bounds.ka.g}`
  ).then(res => {
    setTransmitters(res.data);
  })
  .catch(error => {
    console.warn(error);
  });
};

export const fetchSuccesfulDownloads = (setSuccesfulDownloads, bounds): void => {
  axios.get(
    `/api/succesful_downloads?latmin=${bounds.pa.g}&latmax=${bounds.pa.h}&lngmin=${bounds.ka.g}&lngmax=${bounds.ka.h}`
  ).then(res => {
    setSuccesfulDownloads(res.data);
  })
  .catch(error => {
    console.warn(error);
  });
}

export const fetchFailedDownloads = (setFailedDownloads, bounds): void => {
  axios.get(
    `/api/failed_downloads?latmin=${bounds.pa.g}&latmax=${bounds.pa.h}&lngmin=${bounds.ka.g}&lngmax=${bounds.ka.h}`
  ).then(res => {
    setFailedDownloads(res.data);
  })
  .catch(error => {
    console.warn(error);
  });
}

export const fetchAntennaSearch = (): void => {
  axios.get(
    "http://www.antennasearch.com/sitestart.asp",
    {
      params: {
        reportname001: "antennacheck",
        statename001: "ny",
        cityname001: "nyc",
        Address001: "20+Grand+St%2C+Brooklyn%2C+NY+11211",
        latitude001: "40.7162890444501",
        longitude001: "-73.9662015090831",
        raditem: "002",
        reportname002: "antennacheck",
        statename002: "ny",
        cityname002: "nyc",
        Address002: "20+Grand+St%2C+New+York%2C+NY+10013",
        latitude002: "40.723008376158",
        longitude002: "-74.0049866970744",
        x: "45",
        y: "9",
        sourcepagename: "SrchAnt",
        cmdRequest: "process"
      }
    }
  ).then((data) => console.log(data))
}