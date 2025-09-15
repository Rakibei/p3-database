up:
	docker compose up -d


logs:
	docker compose logs -f db


down:
	docker compose down


psql:
	docker compose exec -e PGPASSWORD=$$POSTGRES_PASSWORD db \
		psql -U $$POSTGRES_USER -d $$POSTGRES_DB


shell:
	docker compose exec db bash


# NUKES the database volume (irreversible). Useful if you want to re-run init scripts.
reset:
	docker compose down -v
	docker compose up -d


# Dump the current DB to a file (./db/init/99_dump.sql)
dump:
	docker compose exec -e PGPASSWORD=$$POSTGRES_PASSWORD db \
		pg_dump -U $$POSTGRES_USER -d $$POSTGRES_DB -F p > db/init/99_dump.sql


# Restore from a dump file
restore:
	# Usage: make restore FILE=./db/init/99_dump.sql
	cat $(FILE) | docker compose exec -T -e PGPASSWORD=$$POSTGRES_PASSWORD db \
		psql -U $$POSTGRES_USER -d $$POSTGRES_DB