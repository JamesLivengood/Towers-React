import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import TowerMap from '../Pages/TowerMap';

const RoutesContainer = () => (
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<TowerMap />} />
      <Route path="/downloads-map" element={<TowerMap downloads={true} />} />
    </Routes>
  </BrowserRouter>
);

export default RoutesContainer;
