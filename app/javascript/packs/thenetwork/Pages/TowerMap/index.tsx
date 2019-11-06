import React, { FC } from 'react';
import { Map, InfoWindow, Marker, GoogleApiWrapper } from 'google-maps-react';
import { fetchTowers, fetchTransmitters } from '../../Utils/fetches';

const TowerMap = ({ google }) => {
  const [zoom, setZoom] = React.useState(() => {
    return localStorage.zoom ? parseFloat(localStorage.zoom) : 11
  });
  const [center, setCenter] = React.useState(() => {
    return { lat: localStorage.lat || 40.101013, lng: localStorage.lng || -74.404992 } }
  );
  const [towers, setTowers] = React.useState(() => []);
  const [transmitters, setTransmitters] = React.useState(() => []);
  const [centerMarker, setCenterMarker] = React.useState(() => undefined)
  const [activeMarker, setActiveMarker] = React.useState(() => { return { marker: undefined, item: undefined } });

  const fetchMarkers = (mapProps, map): void => {
    fetchTowers(setTowers, map.getBounds());
    fetchTransmitters(setTransmitters, map.getBounds());
  }

  const saveCenterAndZoom = (mapProps, map): void => {
    localStorage.lat = map.getCenter().lat();
    localStorage.lng = map.getCenter().lng();
    localStorage.zoom = map.zoom;
  }

  const onLoad = () => {
    var input = document.getElementById('pac-input')
    var m_map = document.getElementById('map')
    var searchBox = new google.maps.places.SearchBox(input)

    searchBox.addListener('places_changed', function () {
      console.log('places changed !!')

      var places = searchBox.getPlaces();
      var location = places[0].geometry.location;
      setCenter({ lat: location.lat(), lng: location.lng() });

      localStorage.lat = location.lat();
      localStorage.lng = location.lng();

      setCenterMarker({ lat: location.lat(), lng: location.lng() })
    });
  };

  const openMarker = (props, marker, e) => {
    setActiveMarker({ marker, item: marker.item });
  }

  const towerInfo = (tower) => {
    return {
      tower_type: tower.tower_type,
      date_constructed: tower.date_constructed,
      height_of_structure: tower.height_of_structure,
      ground_elevation: tower.ground_elevation,
      overall_height_above_ground: tower.overall_height_above_ground,
      overall_height_amsl: tower.overall_height_amsl,
      structure_type: tower.structure_type
    }
  }

  const transmitterInfo = (transmitter) => {
    return {
      sitetype: transmitter.sitetype,
      ground_elevation: transmitter.ground_elevation,
      height_of_support_structure: transmitter.height_of_support_structure,
      overall_height_of_structure: transmitter.overall_height_of_structure,
      structure_type: transmitter.structure_type,
      emmitter_1_freqs_mhz: transmitter.emmitter_1_freqs_mhz,
      emmitter_2_freqs_mhz: transmitter.emmitter_2_freqs_mhz,
      emmitter_3_freqs_mhz: transmitter.emmitter_3_freqs_mhz,
      emmitter_4_freqs_mhz: transmitter.emmitter_4_freqs_mhz,
      emmitter_5_freqs_mhz: transmitter.emmitter_5_freqs_mhz
    }
  }

  return (
    <div>
      <input id={"pac-input"} type={"text"} placeholder={"Search Box"} />
      <Map
        google={google}
        zoom={zoom}
        initialCenter={center}
        center={center}
        onReady={onLoad}
        scaleControl={true}
        style={{ height: '100%', width: '100%' }}
        onTilesloaded={saveCenterAndZoom}
        onIdle={fetchMarkers}
        id="map"
      >
        {
          towers.map((tower, idx) => {
            let noHeight = !parseInt(tower.height_of_structure);
            let size = noHeight ? 15 : Math.pow(tower.height_of_structure / 55, 0.33) * 22;
            return (
              <Marker
                key={idx}
                position={{ lat: tower.latitude, lng: tower.longitude }}
                icon={{
                  url: `http://maps.google.com/mapfiles/ms/icons/${noHeight ? 'orange' : 'red'}-dot.png`,
                  scaledSize: new google.maps.Size(size, size)
                }}
                onClick={openMarker}
                item={towerInfo(tower)}
              />
            );
          })
        }
        {
          transmitters.map((t, idx) => {
            // let noHeight = !parseInt(t.overall_height_of_structure);
            let size = 13//noHeight ? 11 : (t.overall_height_of_structure / 55) * 11;
            return (
              <Marker
                key={idx}
                position={{ lat: t.latitude, lng: t.longitude }}
                icon={{
                  url: `http://maps.google.com/mapfiles/ms/icons/${t.sitetype == "Multiple" ? 'yellow' : 'blue'}-dot.png`,
                  scaledSize: new google.maps.Size(size, size)
                }}
                onClick={openMarker}
                item={transmitterInfo(t)}
              />
            );
          })
        }
        { centerMarker ?
          <Marker
            key="centerMarker"
            position={{ lat: centerMarker.lat, lng: centerMarker.lng }}
            icon={{
              url: "http://maps.google.com/mapfiles/ms/icons/purple-dot.png",
              scaledSize: new google.maps.Size(27, 27)
            }}
          /> : undefined
        }
        <InfoWindow
          visible={!!activeMarker.marker}
          marker={activeMarker.marker}
        >
          <ul>
            {console.log(activeMarker)}
            {activeMarker.item ? Object.keys(activeMarker.item).map((key) => {
              return <li key={key} style={{ fontSize: '14px' }}>{key}: {activeMarker.item[key]}</li>
            }) : undefined}
          </ul>
        </InfoWindow>
      </Map>
    </div>
  );
};

export default GoogleApiWrapper({
  apiKey: ('AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4')
})(TowerMap);
