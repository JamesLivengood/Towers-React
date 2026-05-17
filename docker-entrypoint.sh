#!/bin/sh
set -e

# Run database migrations on every deploy
# Fly.io runs this once per machine; safe for single-VM setups
echo "==> Running db:migrate..."
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup

exec "$@"
