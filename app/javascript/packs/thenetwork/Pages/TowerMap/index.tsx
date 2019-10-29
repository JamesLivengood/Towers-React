import React, { FC } from 'react';
import { Map, InfoWindow, Marker, GoogleApiWrapper } from 'google-maps-react';
import axios from 'axios';

const TowerMap = ({ google }) => {
  const initialCenter = { lat: 40.101013, lng: -74.404992 };
  const zoom = 11;
  const [towers, setTowers] = React.useState([]);
  const [transmitters, setTransmitters] = React.useState([]);

  const fetchMarkers = (): void => {
    fetchTowers();
    fetchTransmitters();
  }

  const fetchTowers = (): void => {
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

  const fetchTransmitters = (): void => {
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

  const blueIconUrl = "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"

  return (
    <Map
      google={google}
      zoom={zoom}
      initialCenter={initialCenter}
      style={{ height: '100%', width: '100%' }}
      onReady={fetchMarkers}
    >
      {
        towers.map((tower, idx) => {
          return (
            <Marker key={idx} position={{ lat: tower.latitude, lng: tower.longitude }} />
          );
        })
      }
      {
        transmitters.map((t, idx) => {
          return (
            <Marker
              key={idx}
              position={{ lat: t.latitude, lng: t.longitude }}
              icon={{ url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png" }}
            />
          );
        })
      }
    </Map>
  );
};

export default GoogleApiWrapper({
  apiKey: ('AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4')
})(TowerMap);
