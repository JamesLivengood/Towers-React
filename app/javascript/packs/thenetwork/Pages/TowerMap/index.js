import React from 'react';
import { Map, InfoWindow, Marker, GoogleApiWrapper } from 'google-maps-react';
import { fetchTowers, fetchTransmitters, fetchSuccesfulDownloads, fetchFailedDownloads } from '../../Utils/fetches';
import { towerInfo, transmitterInfo } from '../../Utils/infoMappers';
import Key from '../../Common/Components/Key';
var TowerMap = function (_a) {
    var google = _a.google, downloads = _a.downloads;
    var _b = React.useState(function () {
        return localStorage.zoom ? parseFloat(localStorage.zoom) : 11;
    }), zoom = _b[0], setZoom = _b[1];
    var _c = React.useState(function () {
        return { lat: localStorage.lat || 40.101013, lng: localStorage.lng || -74.404992 };
    }), center = _c[0], setCenter = _c[1];
    var _d = React.useState(function () { return []; }), towers = _d[0], setTowers = _d[1];
    var _e = React.useState(function () { return []; }), transmitters = _e[0], setTransmitters = _e[1];
    var _f = React.useState(function () { return []; }), succesfulDownloads = _f[0], setSuccesfulDownloads = _f[1];
    var _g = React.useState(function () { return []; }), failedDownloads = _g[0], setFailedDownloads = _g[1];
    var _h = React.useState(function () { return undefined; }), centerMarker = _h[0], setCenterMarker = _h[1];
    var _j = React.useState(function () { return { marker: undefined, item: undefined }; }), activeMarker = _j[0], setActiveMarker = _j[1];
    var fetchMarkers = function (mapProps, map) {
        if (downloads) {
            fetchSuccesfulDownloads(setSuccesfulDownloads, map.getBounds());
            fetchFailedDownloads(setFailedDownloads, map.getBounds());
        }
        else {
            fetchTowers(setTowers, map.getBounds());
            fetchTransmitters(setTransmitters, map.getBounds());
        }
    };
    var saveCenterAndZoom = function (mapProps, map) {
        localStorage.lat = map.getCenter().lat();
        localStorage.lng = map.getCenter().lng();
        localStorage.zoom = map.zoom;
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
            localStorage.lat = location.lat();
            localStorage.lng = location.lng();
            setCenterMarker({ lat: location.lat(), lng: location.lng() });
        });
    };
    var openMarker = function (props, marker, e) {
        setActiveMarker({ marker: marker, item: marker.item });
    };
    return (React.createElement("div", null,
        React.createElement("input", { id: "pac-input", type: "text", placeholder: "Search Box" }),
        React.createElement(Map, { google: google, zoom: zoom, initialCenter: center, center: center, onReady: onLoad, scaleControl: true, style: { height: '100%', width: '100%' }, onTilesloaded: saveCenterAndZoom, onIdle: fetchMarkers, id: "map" },
            towers.map(function (tower, idx) {
                var noHeight = !parseInt(tower.height_of_structure);
                var size = noHeight ? 15 : Math.pow(tower.height_of_structure / 55, 0.33) * 22;
                return (React.createElement(Marker, { key: idx, position: { lat: tower.latitude, lng: tower.longitude }, icon: {
                        url: "http://maps.google.com/mapfiles/ms/icons/" + (noHeight ? 'orange' : 'red') + "-dot.png",
                        scaledSize: new google.maps.Size(size, size)
                    }, onClick: openMarker, item: towerInfo(tower) }));
            }),
            transmitters.map(function (t, idx) {
                // let noHeight = !parseInt(t.overall_height_of_structure);
                var size = 13; //noHeight ? 11 : (t.overall_height_of_structure / 55) * 11;
                return (React.createElement(Marker, { key: idx, position: { lat: t.latitude, lng: t.longitude }, icon: {
                        url: "http://maps.google.com/mapfiles/ms/icons/" + (t.sitetype == "Multiple" ? 'yellow' : 'blue') + "-dot.png",
                        scaledSize: new google.maps.Size(size, size)
                    }, onClick: openMarker, item: transmitterInfo(t) }));
            }),
            succesfulDownloads.map(function (sd, idx) {
                return (React.createElement(Marker, { key: idx, position: { lat: sd.lat, lng: sd.lng }, icon: {
                        path: google.maps.SymbolPath.CIRCLE,
                        // scale: 108, // 1 mi
                        scale: 23,
                        fillColor: "#F00",
                        fillOpacity: 0.3,
                        strokeWeight: 0.1
                    } }));
            }),
            failedDownloads.map(function (fd, idx) {
                return (React.createElement(Marker, { key: idx, position: { lat: fd.lat, lng: fd.lng }, icon: {
                        path: google.maps.SymbolPath.CIRCLE,
                        // scale: 108, // 1 mi
                        scale: 23,
                        fillColor: "#0000ff",
                        fillOpacity: 0.3,
                        strokeWeight: 0.1
                    } }));
            }),
            centerMarker ?
                React.createElement(Marker, { key: "centerMarker", position: { lat: centerMarker.lat, lng: centerMarker.lng }, icon: {
                        url: "http://maps.google.com/mapfiles/ms/icons/purple-dot.png",
                        scaledSize: new google.maps.Size(27, 27)
                    } }) : undefined,
            React.createElement(InfoWindow, { visible: !!activeMarker.marker, marker: activeMarker.marker },
                React.createElement("ul", null,
                    console.log(activeMarker),
                    activeMarker.item ? Object.keys(activeMarker.item).map(function (key) {
                        return React.createElement("li", { key: key, style: { fontSize: '14px' } },
                            key,
                            ": ",
                            activeMarker.item[key]);
                    }) : undefined))),
        React.createElement(Key, null)));
};
export default GoogleApiWrapper({
    apiKey: ('AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4')
})(TowerMap);
//# sourceMappingURL=index.js.map