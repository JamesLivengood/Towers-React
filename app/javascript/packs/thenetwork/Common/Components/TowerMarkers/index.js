import React from 'react';
import { Marker } from 'google-maps-react';
import { towerInfo } from '../../../Utils/infoMappers';
var TowerMarkers = function (_a) {
    var google = _a.google, towers = _a.towers, setActiveMarker = _a.setActiveMarker;
    var normalizedHeight = function (height) {
        var heightNum = parseInt(height);
        if (!heightNum) {
            return 15;
        }
        else {
            return Math.pow(heightNum / 55, 0.33) * 22;
        }
    };
    var openMarker = function (props, marker, e) {
        // setActiveMarker({ marker, item: marker.item });
    };
    // return (
    //   <div>
    //     {[1, 2, 3].map((x) =>
    //       <Marker />
    //     )}
    //   </div>
    // );
    return (React.createElement("div", null, towers.map(function (tower, idx) {
        var markerSize = normalizedHeight(tower.height_of_structure);
        return (React.createElement(Marker, { key: idx, position: {
                lat: tower.latitude,
                lng: tower.longitude
            }, icon: {
                url: "http://maps.google.com/mapfiles/ms/icons/" + (markerSize === 15 ? 'orange' : 'red') + "-dot.png",
                scaledSize: new google.maps.Size(markerSize, markerSize)
            }, onClick: openMarker, item: towerInfo(tower) }));
    })));
};
export default TowerMarkers;
//# sourceMappingURL=index.js.map