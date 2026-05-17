#!/bin/bash
set -e

if [ ! -f .env ]; then
  echo "Error: .env file not found. Create one with VITE_GOOGLE_MAPS_API_KEY=your_key_here"
  exit 1
fi

MAPS_KEY=$(grep VITE_GOOGLE_MAPS_API_KEY .env | cut -d= -f2)

if [ -z "$MAPS_KEY" ]; then
  echo "Error: VITE_GOOGLE_MAPS_API_KEY not found in .env"
  exit 1
fi

fly deploy -a towers-react --build-arg VITE_GOOGLE_MAPS_API_KEY="$MAPS_KEY"
