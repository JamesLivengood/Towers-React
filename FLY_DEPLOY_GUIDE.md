# Fly.io Deployment Guide — Towers-React

## Prerequisites
- [Fly.io account](https://fly.io) (free, needs a credit card for verification but won't charge for free tier)
- `flyctl` CLI installed: https://fly.io/docs/hands-on/install-flyctl/

---

## Step 1 — Copy files into your repo

Copy these three files into the **root** of your project:

- `Dockerfile`
- `docker-entrypoint.sh`
- `fly.toml`

---

## Step 2 — Fix your Procfile (important!)

Your current `Procfile` has a webpack-dev-server worker which is dev-only.
Replace its contents with:

```
web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq
```

> The `worker` process is only used if you run a separate Fly machine for Sidekiq.
> For the free tier, Sidekiq can be omitted or run in-process if your background jobs are light.

---

## Step 3 — Login and launch

```bash
flyctl auth login
flyctl launch --no-deploy
```

When prompted:
- **App name**: choose something unique (e.g. `towers-react-yourname`)
- **Region**: `dfw` (Dallas) is closest to Mexico City
- **Postgres**: say **Yes** — Fly will create a free Postgres cluster
- **Redis**: say **No** for now (we'll add Upstash separately)

This will update the `app` name in `fly.toml` automatically.

---

## Step 4 — Set up Upstash Redis (free)

```bash
flyctl ext upstash redis create
```

Follow the prompts. This automatically sets the `REDIS_URL` secret on your app.

Then make sure your Rails config uses it. In `config/environments/production.rb` or
an initializer, ensure Sidekiq is configured:

```ruby
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end
```

---

## Step 5 — Set secrets

```bash
flyctl secrets set \
  SECRET_KEY_BASE=$(openssl rand -hex 64) \
  GOOGLE_MAPS_API_KEY=your_key_here \
  RAILS_MASTER_KEY=$(cat config/master.key)
```

Add any other API keys your app needs (Google API, etc.).

---

## Step 6 — Deploy

```bash
flyctl deploy
```

This will:
1. Build the Docker image (installs gems + Node deps + Vite build)
2. Push to Fly's registry
3. Run `db:migrate` via the entrypoint script
4. Start Puma on port 3000

---

## Step 7 — Open your app

```bash
flyctl open
```

---

## Useful commands

| Command | What it does |
|---|---|
| `flyctl logs` | Tail live logs |
| `flyctl ssh console` | SSH into the running VM |
| `flyctl secrets list` | See which secrets are set |
| `flyctl status` | Check machine health |
| `flyctl deploy` | Redeploy after code changes |

---

## Memory tips (free tier has 256MB)

Add these to your `fly.toml` `[env]` section if you run into OOM issues:

```toml
MALLOC_ARENA_MAX = "2"
RUBY_GC_HEAP_GROWTH_FACTOR = "1.1"
```

And in `config/puma.rb`, keep workers low:

```ruby
workers ENV.fetch("WEB_CONCURRENCY") { 1 }
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 3 }
threads threads_count, threads_count
```

---

## About Sidekiq on the free tier

Your app uses Sidekiq + Redis. On the free tier you have 3 VMs total:
- 1 for the Rails/Puma web process
- 1 for Sidekiq worker (optional — only needed if background jobs are critical)
- Postgres uses its own free cluster outside your VM quota

If Sidekiq jobs are not time-sensitive, you can skip the worker VM initially and
add it later by uncommenting the `[[processes]]` block in `fly.toml`.
