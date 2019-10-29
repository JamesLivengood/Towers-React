import React, { FC } from 'react';
import { Map, InfoWindow, Marker, GoogleApiWrapper } from 'google-maps-react';
import { fetchTowers, fetchTransmitters } from '../../Utils/fetches';
const TowerMap = ({ google }) => {
  const initialCenter = { lat: 40.101013, lng: -74.404992 };
  const zoom = 11;
  const [towers, setTowers] = React.useState([]);
  const [transmitters, setTransmitters] = React.useState([]);

  const fetchMarkers = (): void => {
    fetchTowers(setTowers);
    fetchTransmitters(setTransmitters);
    onLoad();
  }

  const onLoad = () => {
    var input = document.getElementById('pac-input')
    var m_map = document.getElementById('map')
    var searchBox = new google.maps.places.SearchBox(input)

    searchBox.addListener('places_changed', function () {
      console.log('places changed !!')

      var places = searchBox.getPlaces();
      console.log(places[0].geometry.location.lat())

      // this.setState({
      //   mapCenter: { lat: places[0].geometry.location.lat(), lng: places[0].geometry.location.lng() }
      // },
      //   () => this.onLatLngChanged());

    });
  };

  const blueIconUrl = "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"

  return (
    <div>
      <input id={"pac-input"} type={"text"} placeholder={"Search Box"} />
      <Map
        google={google}
        zoom={zoom}
        initialCenter={initialCenter}
        style={{ height: '100%', width: '100%' }}
        onReady={fetchMarkers}
        id="map"
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
    </div>
  );
};

export default GoogleApiWrapper({
  apiKey: ('AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4')
})(TowerMap);
