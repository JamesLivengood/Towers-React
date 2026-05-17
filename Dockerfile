# syntax=docker/dockerfile:1

# -----------------------------------------------
# Stage 1: Build Vite/React assets
# -----------------------------------------------
FROM node:20-slim AS node_builder

WORKDIR /app

COPY package.json package-lock.json* yarn.lock* ./
RUN npm install

COPY . .
ARG VITE_GOOGLE_MAPS_API_KEY
ENV VITE_GOOGLE_MAPS_API_KEY=$VITE_GOOGLE_MAPS_API_KEY
RUN npm run build

# -----------------------------------------------
# Stage 2: Ruby/Rails app
# -----------------------------------------------
FROM ruby:3.3.6-slim AS rails_app

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libpq-dev \
      libpq5 \
      curl \
      git \
      pkg-config && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /rails

ENV RAILS_ENV=production \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

COPY Gemfile ./
RUN bundle install --jobs 4 --retry 3 && \
    rm -rf "${BUNDLE_PATH}"/ruby/*/cache

# Copy Vite-built assets from node stage
COPY --from=node_builder /app/public/vite /rails/public/vite

# Copy application code
COPY . .

# Compile Sprockets CSS (Vite already built in node_builder stage above)
RUN VITE_RUBY_SKIP_ASSETS_PRECOMPILE_EXTENSION=true \
    SECRET_KEY_BASE_DUMMY=1 \
    bundle exec rails assets:precompile

# Set up entrypoint and non-root user
COPY --chmod=755 docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN mkdir -p /rails/tmp/pids /rails/log && \
    useradd --create-home --shell /bin/bash rails && \
    chown -R rails:rails /rails
USER rails

EXPOSE 3000
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
