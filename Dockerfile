# syntax=docker/dockerfile:1

# -----------------------------------------------
# Stage 1: Build Vite/React assets
# -----------------------------------------------
FROM node:20-slim AS node_builder

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .

# Build Vite assets for production
RUN yarn build

# -----------------------------------------------
# Stage 2: Ruby/Rails app
# -----------------------------------------------
FROM ruby:3.3.6-slim AS rails_app

# Install system dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libpq-dev \
      curl \
      git \
      libssl-dev \
      pkg-config && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && \
    bundle install --jobs 4 --retry 3

# Copy built Vite assets from node_builder stage
COPY --from=node_builder /app/public/vite /app/public/vite

# Copy the rest of the app
COPY . .

# Precompile assets (sprockets/dartsass)
# VITE_RUBY_SKIP_ASSETS_PRECOMPILE=true because we already built above
ENV RAILS_ENV=production \
    VITE_RUBY_SKIP_ASSETS_PRECOMPILE=true \
    SECRET_KEY_BASE=placeholder_for_asset_precompile

RUN bundle exec rails assets:precompile

# Clean up placeholder secret
ENV SECRET_KEY_BASE=""

EXPOSE 3000

# Use a shell entrypoint so we can run db:migrate before starting Puma
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
