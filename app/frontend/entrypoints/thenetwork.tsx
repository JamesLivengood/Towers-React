import React from 'react';
import { createRoot } from 'react-dom/client';
import App from '../App';

document.addEventListener('DOMContentLoaded', () => {
  const container =
    document.getElementById('root') ??
    document.body.appendChild(document.createElement('div'));
  createRoot(container).render(<App />);
});
