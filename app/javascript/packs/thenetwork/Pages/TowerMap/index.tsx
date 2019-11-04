import React, { FC } from 'react';
import { Map, InfoWindow, Marker, GoogleApiWrapper } from 'google-maps-react';
import { fetchTowers, fetchTransmitters } from '../../Utils/fetches';

const TowerMap = ({ google }) => {
  const [zoom, setZoom] = React.useState(11);
  const [center, setCenter] = React.useState({ lat: localStorage.lat || 40.101013, lng: localStorage.lng || -74.404992 });
  const [towers, setTowers] = React.useState([]);
  const [transmitters, setTransmitters] = React.useState([]);
  const [centerMarker, setCenterMarker] = React.useState(undefined)

  const fetchMarkers = (mapProps, map): void => {
    fetchTowers(setTowers, map.getBounds());
    fetchTransmitters(setTransmitters, map.getBounds());
    onLoad();
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

  const saveCenter = (mapProps, map) => {
    localStorage.lat = map.getCenter().lat()
    localStorage.lng = map.getCenter().lng()
  }

  const blueIconUrl = "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"

  return (
    <div>
      <input id={"pac-input"} type={"text"} placeholder={"Search Box"} />
      <Map
        google={google}
        zoom={zoom}
        initialCenter={center}
        center={center}
        onDragend={saveCenter}
        style={{ height: '100%', width: '100%' }}
        onTilesloaded={fetchMarkers}
        id="map"
      >
        {
          towers.map((tower, idx) => {
            return (
              <Marker
                key={idx}
                position={{ lat: tower.latitude, lng: tower.longitude }}
                icon={{
                  url: "http://maps.google.com/mapfiles/ms/icons/red-dot.png",
                  scaledSize: new google.maps.Size(32, 32)
                }}
              />
            );
          })
        }
        {
          transmitters.map((t, idx) => {
            return (
              <Marker
                key={idx}
                position={{ lat: t.latitude, lng: t.longitude }}
                icon={{
                  url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png",
                  scaledSize: new google.maps.Size(21, 21)
                  // size: new google.maps.Size(25, 50)
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
      </Map>
    </div>
  );
};

export default GoogleApiWrapper({
  apiKey: ('AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4')
})(TowerMap);
