import React, { FC } from 'react';

const SearchBox = ({ google, setCenter, setCenterMarker }) => {
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

  return (
    <input id={"pac-input"} type={"text"} placeholder={"Search Box"} />
  );
}

export default SearchBox;