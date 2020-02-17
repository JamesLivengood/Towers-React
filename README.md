# README

```bundle install```

```npm install```

```spring rake db:reset```

```spring rails s```

```ruby ./bin/webpack-dev-server```

Uses google-maps-react package: https://github.com/fullstackreact/google-maps-react

Google Maps React docs: https://github.com/fullstackreact/google-maps-react/blob/f1670164ff43244f90803e900278a6c591fac62d/src/index.js

## How to restore db from local

```pg_dump thenetwork_development > backup.sql```

```heroku pg:psql < backup.sql```