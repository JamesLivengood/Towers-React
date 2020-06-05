import React, { FC } from 'react';
import { Marker } from 'google-maps-react';
import { towerInfo } from '../../../Utils/infoMappers';

interface Tower {
  height_of_structure?: string
}

const TowerMarkers = ({ google, towers, setActiveMarker }: { google: any, towers: any[], setActiveMarker?: any }) => {
  const normalizedHeight = (height?: string):number => {
    let heightNum = parseInt(height);

    if (!heightNum) {
      return 15;
    } else {
      return Math.pow(heightNum / 55, 0.33) * 22;
    }
  }

  const openMarker = (props, marker, e) => {
    // setActiveMarker({ marker, item: marker.item });
  }

  // return (
  //   <div>
  //     {[1, 2, 3].map((x) =>
  //       <Marker />
  //     )}
  //   </div>
  // );

  return (
    <div>
      {towers.map((tower, idx) => {
        let markerSize = normalizedHeight(tower.height_of_structure);

        return (
          <Marker
            key={idx}
            position={{
              lat: tower.latitude,
              lng: tower.longitude
            }}
            icon={{
              url: `http://maps.google.com/mapfiles/ms/icons/${markerSize === 15 ? 'orange' : 'red'}-dot.png`,
              scaledSize: new google.maps.Size(markerSize, markerSize)
            }}
            onClick={openMarker}
            item={towerInfo(tower)}
          />
        );
      })}
    </div>
  );
}

export default TowerMarkers;
