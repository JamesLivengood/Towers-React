import React, { FC } from 'react';
import GoogleMapReact from 'google-map-react';

type IProps = {
  centerLat: number,
  centerLng: number,
  zoom: number
};

const TowerMap: FC<IProps> = ({ centerLat = 40.101013, centerLng = -74.404992, zoom = 11 }) => {

  return (
    <GoogleMapReact
      style={{ height: '100%', width: '100%' }}
      bootstrapURLKeys={{
        key: 'AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4',
        language: 'en'
      }}
      defaultCenter={{ lat: centerLat, lng: centerLng }}
      center={{ lat: centerLat, lng: centerLng }}
      defaultZoom={zoom}
    >
    </GoogleMapReact>
  );
};

export default TowerMap;