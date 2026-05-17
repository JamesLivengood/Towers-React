#!/bin/sh
set -e

if [ "$RAILS_ENV" = "production" ]; then
  # Run migrations in background so Puma can start immediately on port 3000.
  # Fly.io's proxy times out in ~8s if the port is not open, so blocking here
  # causes 502s on cold starts when postgres is also waking up.
  (
    attempt=0
    until bundle exec rails db:migrate 2>&1; do
      attempt=$((attempt + 1))
      if [ $attempt -ge 30 ]; then
        echo "Database migration failed after $attempt attempts, giving up"
        break
      fi
      echo "Migration attempt $attempt failed, retrying in 5s..."
      sleep 5
    done
  ) &
fi

exec "$@"
