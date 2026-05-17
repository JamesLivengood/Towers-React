#!/bin/sh
set -e

if [ "$RAILS_ENV" = "production" ]; then
  attempt=0
  until bundle exec rails db:migrate 2>&1; do
    attempt=$((attempt + 1))
    if [ $attempt -ge 10 ]; then
      echo "Database migration failed after $attempt attempts, aborting"
      exit 1
    fi
    echo "Migration attempt $attempt failed, retrying in 5s..."
    sleep 5
  done
fi

exec "$@"
