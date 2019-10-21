import React, { FC } from 'react';
import GoogleMapReact from 'google-map-react';

type IProps = {
  centerLat: number,
  centerLng: number,
  zoom: number
};

const Map: FC<IProps> = ({ centerLat=40.101013, centerLng=-74.404992, zoom=8 }) => {
  return (
    <div style={{ height: '100%', width: '100%' }}>
      <GoogleMapReact
        bootstrapURLKeys={{ key: 'AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4' }}
        defaultCenter={{ centerLat, centerLng }}
        defaultZoom={zoom}
      />
    </div>
  );
};

export { Map };