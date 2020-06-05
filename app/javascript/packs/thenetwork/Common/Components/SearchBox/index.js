import React from 'react';
var SearchBox = function (_a) {
    var google = _a.google, setCenter = _a.setCenter, setCenterMarker = _a.setCenterMarker;
    var onLoad = function () {
        var input = document.getElementById('pac-input');
        var m_map = document.getElementById('map');
        var searchBox = new google.maps.places.SearchBox(input);
        searchBox.addListener('places_changed', function () {
            var places = searchBox.getPlaces();
            var location = places[0].geometry.location;
            setCenter({ lat: location.lat(), lng: location.lng() });
            localStorage.lat = location.lat();
            localStorage.lng = location.lng();
            setCenterMarker({ lat: location.lat(), lng: location.lng() });
        });
    };
    return (React.createElement("input", { id: "pac-input", type: "text", placeholder: "Search Box" }));
};
export default SearchBox;
//# sourceMappingURL=index.js.map