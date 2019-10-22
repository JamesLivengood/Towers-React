import React, { FC } from 'react';
import { Map, InfoWindow, Marker, GoogleApiWrapper } from 'google-maps-react';

const TowerMap = (props) => {
  const initialCenter = { lat: 40.101013, lng: -74.404992 };
  const zoom = 11;
  const google = props.google;

  const fetchPlaces = () => {

  };

  return (
    <Map
      google={google}
      zoom={zoom}
      initialCenter={initialCenter}
      style={{ height: '100%', width: '100%' }}
      onReady={fetchPlaces}
    >
      <Marker position={{lat: 40.102, lng: -74.31}} />
      <Marker position={{ lat: 40.168, lng: -74.21 }} icon={{ url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png", anchor: new google.maps.Point(32, 32)}}/>
    </Map>
  );
};

export default GoogleApiWrapper({
  apiKey: ('AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4')
})(TowerMap);
