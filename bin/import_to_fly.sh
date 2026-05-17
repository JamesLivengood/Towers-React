#!/bin/bash
# Import local development database into Fly.io production postgres.
# Run this after populating your local database with the rake task.
#
# Usage: ./bin/import_to_fly.sh
#
# Requirements:
#   - flyctl installed and logged in (fly auth login)
#   - pg_dump and pg_restore installed (brew install libpq)
#   - Local postgres running with the thenetwork_development database

set -e

LOCAL_DB="thenetwork_development"
DUMP_FILE="/tmp/thenetwork_dump.dump"
PROXY_PORT="5433"

echo "==> Dumping local database: $LOCAL_DB"
pg_dump "$LOCAL_DB" \
  --no-owner \
  --no-acl \
  --format=custom \
  --file="$DUMP_FILE"
echo "    Dump written to $DUMP_FILE"

echo ""
echo "==> Starting proxy tunnel to Fly.io postgres (towers-react-db)..."
fly proxy "$PROXY_PORT:5432" -a towers-react-db &
PROXY_PID=$!
trap "kill $PROXY_PID 2>/dev/null; echo 'Proxy closed.'" EXIT

# Wait for proxy to be ready
sleep 4

echo ""
echo "==> Reading database name and credentials from Fly.io..."
FLY_DB_URL=$(fly ssh console -a towers-react --command "printenv DATABASE_URL" 2>/dev/null | tr -d '\r\n')

if [ -z "$FLY_DB_URL" ]; then
  # Fallback: Fly postgres attach convention names the db after the app
  FLY_DB_NAME="towers_react"
  FLY_DB_USER="towers_react"
  echo "    Could not read DATABASE_URL from app, using defaults:"
  echo "    db=$FLY_DB_NAME  user=$FLY_DB_USER"
else
  # Parse postgres://user:password@host/dbname
  FLY_DB_USER=$(echo "$FLY_DB_URL" | sed -E 's|postgres://([^:]+):.*|\1|')
  FLY_DB_PASS=$(echo "$FLY_DB_URL" | sed -E 's|postgres://[^:]+:([^@]+)@.*|\1|')
  FLY_DB_NAME=$(echo "$FLY_DB_URL" | sed -E 's|.*/([^?]+).*|\1|')
  echo "    db=$FLY_DB_NAME  user=$FLY_DB_USER"
fi

echo ""
echo "==> Restoring into Fly.io postgres..."
echo "    (This may take a while for large databases)"
PGPASSWORD="${FLY_DB_PASS:-}" pg_restore \
  --verbose \
  --clean \
  --if-exists \
  --no-owner \
  --no-acl \
  -h localhost \
  -p "$PROXY_PORT" \
  -U "${FLY_DB_USER:-postgres}" \
  -d "$FLY_DB_NAME" \
  "$DUMP_FILE"

echo ""
echo "==> Done! Database imported to Fly.io."
echo "    You can verify by visiting https://towers-react.fly.dev/"
