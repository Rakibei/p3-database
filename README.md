# Local Postgres Database using Docker
A quick local database for the 3rd semester project
## Quickstart

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) (or Docker Engine + Compose v2).
2. Clone this repo and make a copy of the env file:
   ```bash
   cp .env.example .env
   ```
3. (Optional) Edit `.env` to change DB name, user, password, and ports.
4. (Optional) Install Make using [Chocolatey](https://chocolatey.org/install#install-step2) in a terminal with elevated permissions:
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

Any `*.sql` files in `db/init/` **only** run automatically **the first time** the DB starts (when `db_data` volume is empty).

If you need to re-run them or made chances to the .env, use:

```bash
docker compose down -v && docker compose up -d
# or
make reset
```

To capture a snapshot of the current database, create a dump:

```bash
make dump
# Commit db/init/99_dump.sql if you want others to get your snapshot on first run
```

## Common commands

### `make up`
- **What it does:** Runs `docker compose up -d`.
- **Effect:** Starts your PostgreSQL and Adminer containers in the background (“detached” mode).
- **When to use:** Whenever you want to bring the database online for local development.

### `make down`
- **What it does:** Runs `docker compose down`.
- **Effect:** Stops and removes the containers, but **keeps your database data** because the volume is not removed.
- **When to use:** When you want to stop everything without deleting the database contents.

### `make logs`
- **What it does:** Runs `docker compose logs -f db`.
- **Effect:** Streams logs from the `db` container (Postgres).
- **When to use:** If something goes wrong (e.g., database won’t start, schema fails to load), check here for errors.

### `make shell`
- **What it does:** Runs `docker compose exec db bash`.
- **Effect:** Opens a bash shell inside the Postgres container.
- **When to use:** Advanced debugging — lets you poke around inside the container itself.

### `make psql`
- **What it does:** Opens the `psql` command-line client inside the `db` container.
- **Effect:** Lets you run SQL commands interactively against your database.
- **When to use:** Quick queries, checking schema, testing SQL without needing a GUI tool.

### `make restore FILE=...`
- **What it does:** Pipes the contents of a SQL file into `psql` inside the container.
- **Effect:** Restores a database dump into your running DB.
- **When to use:** If someone else shared a dump file with you, or you want to roll back to a known snapshot.
