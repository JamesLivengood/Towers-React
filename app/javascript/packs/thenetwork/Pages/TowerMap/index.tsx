import React, { FC } from 'react';
import { Map, InfoWindow, Marker, GoogleApiWrapper, Circle } from 'google-maps-react';
import { fetchTowers, fetchTransmitters, fetchSuccesfulDownloads, fetchFailedDownloads } from '../../Utils/fetches';
import { towerInfo, transmitterInfo } from '../../Utils/infoMappers';
import Key from '../../Common/Components/Key';

const TowerMap = ({ google, downloads }) => {
  const [zoom, setZoom] = React.useState(() => {
    return localStorage.zoom ? parseFloat(localStorage.zoom) : 11
  });
  const [center, setCenter] = React.useState(() => {
    return { lat: localStorage.lat || 40.101013, lng: localStorage.lng || -74.404992 } }
  );
  const [towers, setTowers] = React.useState(() => []);
  const [transmitters, setTransmitters] = React.useState(() => []);
  const [succesfulDownloads, setSuccesfulDownloads] = React.useState(() => []);
  const [failedDownloads, setFailedDownloads] = React.useState(() => []);
  const [centerMarker, setCenterMarker] = React.useState(() => undefined)
  const [activeMarker, setActiveMarker] = React.useState(() => { return { marker: undefined, item: undefined } });

  const fetchMarkers = (mapProps, map): void => {
    if (downloads) {
      fetchSuccesfulDownloads(setSuccesfulDownloads, map.getBounds());
      fetchFailedDownloads(setFailedDownloads, map.getBounds());
    } else {
      fetchTowers(setTowers, map.getBounds());
      fetchTransmitters(setTransmitters, map.getBounds());
    }
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
        {
          succesfulDownloads.map((sd, idx) => {
            return (
              <Marker
                key={idx}
                position={{ lat: sd.lat, lng: sd.lng }}
                icon = {{
                  path: google.maps.SymbolPath.CIRCLE,
                  // scale: 108, // 1 mi
                  scale: 23, // 5 mi
                  fillColor: "#F00",
                  fillOpacity: 0.3,
                  strokeWeight: 0.1
                }}
              />
            );
          })
        }
        {
          failedDownloads.map((fd, idx) => {
            return (
              <Marker
                key={idx}
                position={{ lat: fd.lat, lng: fd.lng }}
                icon = {{
                  path: google.maps.SymbolPath.CIRCLE,
                  // scale: 108, // 1 mi
                  scale: 23, // 5 mi
                  fillColor: "#0000ff",
                  fillOpacity: 0.3,
                  strokeWeight: 0.1
                }}
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
      <Key />
    </div>
  );
};

export default GoogleApiWrapper({
  apiKey: ('AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4')
})(TowerMap);
