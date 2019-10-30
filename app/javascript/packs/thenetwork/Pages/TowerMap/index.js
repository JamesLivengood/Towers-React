import React from 'react';
import { Map, Marker, GoogleApiWrapper } from 'google-maps-react';
import { fetchTowers, fetchTransmitters } from '../../Utils/fetches';
var TowerMap = function (_a) {
    var google = _a.google;
    var _b = React.useState(11), zoom = _b[0], setZoom = _b[1];
    var _c = React.useState({ lat: 40.101013, lng: -74.404992 }), center = _c[0], setCenter = _c[1];
    var _d = React.useState([]), towers = _d[0], setTowers = _d[1];
    var _e = React.useState([]), transmitters = _e[0], setTransmitters = _e[1];
    var fetchMarkers = function () {
        fetchTowers(setTowers);
        fetchTransmitters(setTransmitters);
        onLoad();
    };
    var onLoad = function () {
        var input = document.getElementById('pac-input');
        var m_map = document.getElementById('map');
        var searchBox = new google.maps.places.SearchBox(input);
        searchBox.addListener('places_changed', function () {
            console.log('places changed !!');
            var places = searchBox.getPlaces();
            var location = places[0].geometry.location;
            setCenter({ lat: location.lat(), lng: location.lng() });
        });
        // fetchAntennaSearch();
    };
    var blueIconUrl = "http://maps.google.com/mapfiles/ms/icons/blue-dot.png";
    return (React.createElement("div", null,
        React.createElement("input", { id: "pac-input", type: "text", placeholder: "Search Box" }),
        React.createElement(Map, { google: google, zoom: zoom, initialCenter: center, center: center, style: { height: '100%', width: '100%' }, onReady: fetchMarkers, id: "map" },
            towers.map(function (tower, idx) {
                return (React.createElement(Marker, { key: idx, position: { lat: tower.latitude, lng: tower.longitude } }));
            }),
            transmitters.map(function (t, idx) {
                return (React.createElement(Marker, { key: idx, position: { lat: t.latitude, lng: t.longitude }, icon: { url: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png" } }));
            }))));
};
export default GoogleApiWrapper({
    apiKey: ('AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4')
})(TowerMap);
//# sourceMappingURL=index.js.map