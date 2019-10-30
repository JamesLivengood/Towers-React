import React from 'react';
import GoogleMapReact from 'google-map-react';
var TowerMap = function (_a) {
    var _b = _a.centerLat, centerLat = _b === void 0 ? 40.101013 : _b, _c = _a.centerLng, centerLng = _c === void 0 ? -74.404992 : _c, _d = _a.zoom, zoom = _d === void 0 ? 11 : _d;
    return (React.createElement(GoogleMapReact, { style: { height: '100%', width: '100%' }, bootstrapURLKeys: {
            key: 'AIzaSyAehp1zTFrN3DtQJG2dgduMe8y3Jcbe6r4',
            language: 'en'
        }, defaultCenter: { lat: centerLat, lng: centerLng }, center: { lat: centerLat, lng: centerLng }, defaultZoom: zoom }));
};
export default TowerMap;
//# sourceMappingURL=index.js.map