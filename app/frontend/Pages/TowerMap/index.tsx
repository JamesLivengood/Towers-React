import React, { useCallback, useEffect, useRef, useState } from 'react';
import {
  APIProvider,
  Map,
  Marker,
  InfoWindow,
  useMap,
  useMapsLibrary,
  useApiIsLoaded,
} from '@vis.gl/react-google-maps';
import {
  fetchTowers,
  fetchTransmitters,
  fetchSuccesfulDownloads,
  fetchFailedDownloads,
} from '../../Utils/fetches';
import { towerInfo, transmitterInfo } from '../../Utils/infoMappers';
import Key from '../../Common/Components/Key';
import FoldingCube from '../../Common/Components/FoldingCube';
import { showLoader } from '../../Utils/loaderControllers';

const MAPS_API_KEY = import.meta.env.VITE_GOOGLE_MAPS_API_KEY;

interface ActiveMarker {
  position: google.maps.LatLngLiteral;
  item: Record<string, unknown>;
}

const MapContent: React.FC<{ downloads?: boolean }> = ({ downloads }) => {
  const map = useMap();
  const placesLib = useMapsLibrary('places');
  const searchInputRef = useRef<HTMLInputElement>(null);

  const [towers, setTowers] = useState<Record<string, unknown>[]>([]);
  const [transmitters, setTransmitters] = useState<Record<string, unknown>[]>([]);
  const [successfulDownloads, setSuccessfulDownloads] = useState<{ lat: number; lng: number }[]>([]);
  const [failedDownloads, setFailedDownloads] = useState<{ lat: number; lng: number }[]>([]);
  const [centerMarker, setCenterMarker] = useState<google.maps.LatLngLiteral | null>(null);
  const [activeMarker, setActiveMarker] = useState<ActiveMarker | null>(null);
  const [markerSizeMultiplier, setMarkerSizeMultiplier] = useState(
    () => parseFloat(localStorage.markerSizeMultiplier) || 1
  );

  useEffect(() => {
    if (!placesLib || !searchInputRef.current || !map) return;
    const searchBox = new placesLib.SearchBox(searchInputRef.current);
    searchBox.addListener('places_changed', () => {
      const places = searchBox.getPlaces();
      if (!places?.length) return;
      const loc = places[0].geometry?.location;
      if (!loc) return;
      const pos: google.maps.LatLngLiteral = { lat: loc.lat(), lng: loc.lng() };
      map.panTo(pos);
      setCenterMarker(pos);
      localStorage.lat = pos.lat;
      localStorage.lng = pos.lng;
    });
    return () => google.maps.event.clearInstanceListeners(searchBox);
  }, [placesLib, map]);

  const handleIdle = useCallback(() => {
    if (!map) return;
    const bounds = map.getBounds();
    if (!bounds) return;

    const center = map.getCenter();
    if (center) {
      localStorage.lat = center.lat();
      localStorage.lng = center.lng();
    }
    localStorage.zoom = map.getZoom();

    showLoader();
    if (downloads) {
      fetchSuccesfulDownloads(
        (d) => setSuccessfulDownloads(d as { lat: number; lng: number }[]),
        bounds
      );
      fetchFailedDownloads(
        (d) => setFailedDownloads(d as { lat: number; lng: number }[]),
        bounds
      );
    } else {
      fetchTowers((d) => setTowers(d as Record<string, unknown>[]), bounds);
      fetchTransmitters((d) => setTransmitters(d as Record<string, unknown>[]), bounds);
    }
  }, [map, downloads]);

  const adjustMarkerSizeMultiplier = useCallback(
    (e: React.MouseEvent) => {
      const classList = (e.currentTarget as Element).classList.value;
      const delta = classList.includes('fa-plus') ? 0.1 : -0.1;
      const updated = markerSizeMultiplier + delta;
      localStorage.markerSizeMultiplier = updated;
      setMarkerSizeMultiplier(updated);
    },
    [markerSizeMultiplier]
  );

  return (
    <div style={{ position: 'relative', height: '100vh', width: '100%' }}>
      <input ref={searchInputRef} id="pac-input" type="text" placeholder="Search Box" />
      <Map
        defaultCenter={{
          lat: parseFloat(localStorage.lat) || 40.35658673905037,
          lng: parseFloat(localStorage.lng) || -74.67068971274729,
        }}
        defaultZoom={Math.max(parseFloat(localStorage.zoom) || 13, 13)}
        minZoom={13}
        onIdle={handleIdle}
        id="map"
        style={{ height: '100%', width: '100%' }}
      >
        {towers.map((tower, idx) => {
          const noHeight = !parseInt(String(tower.height_of_structure));
          const size =
            (noHeight
              ? 15
              : Math.pow(Number(tower.height_of_structure) / 55, 0.33) * 22) *
            markerSizeMultiplier;
          return (
            <Marker
              key={idx}
              position={{
                lat: parseFloat(String(tower.latitude)),
                lng: parseFloat(String(tower.longitude)),
              }}
              icon={{
                url: `http://maps.google.com/mapfiles/ms/icons/${noHeight ? 'orange' : 'red'}-dot.png`,
                scaledSize: new google.maps.Size(size, size),
              }}
              onClick={() =>
                setActiveMarker({
                  position: {
                    lat: parseFloat(String(tower.latitude)),
                    lng: parseFloat(String(tower.longitude)),
                  },
                  item: towerInfo(tower),
                })
              }
            />
          );
        })}

        {transmitters.map((t, idx) => {
          const size = 13 * markerSizeMultiplier;
          return (
            <Marker
              key={idx}
              position={{
                lat: parseFloat(String(t.latitude)),
                lng: parseFloat(String(t.longitude)),
              }}
              icon={{
                url: `http://maps.google.com/mapfiles/ms/icons/${t.sitetype === 'Multiple' ? 'yellow' : 'blue'}-dot.png`,
                scaledSize: new google.maps.Size(size, size),
              }}
              onClick={() =>
                setActiveMarker({
                  position: {
                    lat: parseFloat(String(t.latitude)),
                    lng: parseFloat(String(t.longitude)),
                  },
                  item: transmitterInfo(t),
                })
              }
            />
          );
        })}

        {successfulDownloads.map((sd, idx) => (
          <Marker
            key={idx}
            position={{ lat: sd.lat, lng: sd.lng }}
            icon={{
              path: google.maps.SymbolPath.CIRCLE,
              scale: 23,
              fillColor: '#F00',
              fillOpacity: 0.3,
              strokeWeight: 0.1,
            }}
          />
        ))}

        {failedDownloads.map((fd, idx) => (
          <Marker
            key={idx}
            position={{ lat: fd.lat, lng: fd.lng }}
            icon={{
              path: google.maps.SymbolPath.CIRCLE,
              scale: 23,
              fillColor: '#0000ff',
              fillOpacity: 0.3,
              strokeWeight: 0.1,
            }}
          />
        ))}

        {centerMarker && (
          <Marker
            position={centerMarker}
            icon={{
              url: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
              scaledSize: new google.maps.Size(31, 31),
            }}
          />
        )}

        {activeMarker && (
          <InfoWindow
            position={activeMarker.position}
            onCloseClick={() => setActiveMarker(null)}
          >
            <ul>
              {Object.entries(activeMarker.item).map(([key, val]) => (
                <li key={key} style={{ fontSize: '14px' }}>
                  {key}: {String(val)}
                </li>
              ))}
            </ul>
          </InfoWindow>
        )}
      </Map>

      <FoldingCube displayFoldingCube={true} />
      <Key adjustMarkerSizeMultiplier={adjustMarkerSizeMultiplier} />
    </div>
  );
};

const MapLoader: React.FC<{ downloads?: boolean }> = ({ downloads }) => {
  const apiLoaded = useApiIsLoaded();
  if (!apiLoaded) return null;
  return <MapContent downloads={downloads} />;
};

const TowerMap: React.FC<{ downloads?: boolean }> = ({ downloads }) => (
  <APIProvider apiKey={MAPS_API_KEY}>
    <MapLoader downloads={downloads} />
  </APIProvider>
);

export default TowerMap;
