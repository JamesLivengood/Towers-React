import axios from 'axios';
import { hideLoader } from './loaderControllers';

const fetchParams = (bounds: google.maps.LatLngBounds): string => {
  const sw = bounds.getSouthWest();
  const ne = bounds.getNorthEast();
  return `latmin=${sw.lat()}&latmax=${ne.lat()}&lngmin=${sw.lng()}&lngmax=${ne.lng()}`;
};

let activeNorthEastBound: number | null = null;
let activeSouthWestBound: number | null = null;

export const fetchTowers = (
  setTowers: (towers: unknown[]) => void,
  bounds: google.maps.LatLngBounds
): void => {
  const northEastBound = (activeNorthEastBound = bounds.getNorthEast().lat());
  const southWestBound = (activeSouthWestBound = bounds.getSouthWest().lat());

  axios
    .get(`/api/towers?${fetchParams(bounds)}`)
    .then((res) => {
      if (
        northEastBound === activeNorthEastBound ||
        southWestBound === activeSouthWestBound
      ) {
        setTowers(res.data);
      }
    })
    .catch((error) => console.warn(error));
};

export const fetchTransmitters = (
  setTransmitters: (transmitters: unknown[]) => void,
  bounds: google.maps.LatLngBounds
): void => {
  const northEastBound = (activeNorthEastBound = bounds.getNorthEast().lat());
  const southWestBound = (activeSouthWestBound = bounds.getSouthWest().lat());

  axios
    .get(`/api/transmitters?${fetchParams(bounds)}`)
    .then((res) => {
      if (res.data.length === 0) hideLoader();
      if (
        northEastBound === activeNorthEastBound ||
        southWestBound === activeSouthWestBound
      ) {
        setTransmitters(res.data);
        hideLoader();
      }
    })
    .catch((error) => console.warn(error));
};

export const fetchSuccesfulDownloads = (
  setSuccessfulDownloads: (downloads: unknown[]) => void,
  bounds: google.maps.LatLngBounds
): void => {
  axios
    .get(`/api/succesful_downloads?${fetchParams(bounds)}`)
    .then((res) => setSuccessfulDownloads(res.data))
    .catch((error) => console.warn(error));
};

export const fetchFailedDownloads = (
  setFailedDownloads: (downloads: unknown[]) => void,
  bounds: google.maps.LatLngBounds
): void => {
  axios
    .get(`/api/failed_downloads?${fetchParams(bounds)}`)
    .then((res) => setFailedDownloads(res.data))
    .catch((error) => console.warn(error));
};
