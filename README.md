# Local Postgres with Docker Compose

Spin up a ready-to-use Postgres + Adminer with one command. Works on macOS, Windows, and Linux.

## Quickstart

1. Install Docker Desktop (or Docker Engine + Compose v2).
2. Clone this repo and copy the env file:
   ```bash
   cp .env.example .env
   ```
3. (Optional) Edit `.env` to change DB name, user, password, and ports.
4. Start:
   ```bash
   docker compose up -d
   # or
   make up
   ```
5. Connect from your app using:
   - **Host:** `localhost`
   - **Port:** value of `POSTGRES_PORT` (default `5432`)
   - **Database:** `POSTGRES_DB`
   - **User:** `POSTGRES_USER`
   - **Password:** `POSTGRES_PASSWORD`

6. Open Adminer at `http://localhost:${ADMINER_PORT}` (default `8080`).
   - System: **PostgreSQL**
   - Server: **db** (internal) or **localhost** with the mapped port
   - Username/Password: from `.env`
   - Database: from `.env`

## Seeding & schema

Any `*.sql` files in `db/init/` run automatically **only the first time** the DB starts (when `db_data` volume is empty). If you need to re-run them, use:

```bash
docker compose down -v && docker compose up -d
# or
make reset
```

To capture a snapshot of the current database, create a dump:

```bash
make dump
# Commit db/init/99_dump.sql so others get your snapshot on first run
```

## Common commands

```bash
# Start/stop
make up
make down

# Logs & shell
make logs
make shell

# psql prompt
make psql
```

## Notes

- The official `postgres:16` image supports both amd64 and arm64 (Apple Silicon) — no extra flags needed.
- Data persists in the Docker volume `db_data`. Deleting the volume wipes data.
- If your app runs in another container on the same Compose file, use host `db` and port `5432`.
- For CI or GitHub Codespaces, this same compose file works unchanged.
