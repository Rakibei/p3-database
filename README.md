# Local Postgres Database using Docker
A quick local database for the 3rd semester project
## Quickstart

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) (or Docker Engine + Compose v2).
2. Clone this repo and make a copy of the env file:
   ```bash
   cp .env.example .env
   ```
3. (Optional) Edit `.env` to change DB name, user, password, and ports.
4. (Optional) Install Make using [Chocolatey](https://chocolatey.org/install#install-step2):
   ```bash
   choco install make
   ```
5. Start database:
   ```bash
   docker compose up -d
   # or
   make up
   ```
6. Connect from your app using:
   - **Host:** `localhost`
   - **Port:** value of `POSTGRES_PORT` (default `5432`)
   - **Database:** `POSTGRES_DB`
   - **User:** `POSTGRES_USER`
   - **Password:** `POSTGRES_PASSWORD`

7. Open Adminer at `http://localhost:${ADMINER_PORT}` (default `8080`).
   - System: **PostgreSQL**
   - Server: **db** (internal) or **localhost** with the mapped port
   - Username/Password: from `.env`
   - Database: from `.env`

## Seeding & schema

Any `*.sql` files in `db/init/` **only** run automatically **the first time** the DB starts (when `db_data` volume is empty). If you need to re-run them, use:

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
