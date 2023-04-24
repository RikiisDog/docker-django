#!/bin/bash
set -e

psql -U "$POSTGRES_SUPERUSER" -v ON_ERROR_STOP=1 <<-EOSQL
    DO
    \$do\$
    BEGIN
        IF NOT EXISTS (SELECT usename FROM pg_user WHERE usename = "$POSTGRES_USER") THEN
            CREATE USER "$POSTGRES_USER" WITH PASSWORD "$POSTGRES_PASSWORD";
        END IF;
    END
    \$do\$;

    DO
    \$do\$
    BEGIN
        IF NOT EXISTS (SELECT datname FROM pg_database WHERE datname = "$POSTGRES_DB") THEN
            CREATE DATABASE "$POSTGRES_DB" WITH OWNER "$POSTGRES_USER" TEMPLATE template0 ENCODING 'UTF8' LC_COLLATE 'C' LC_CTYPE 'C';
            GRANT ALL PRIVILEGES ON DATABASE "$POSTGRES_DB" TO "$POSTGRES_USER";
        END IF;
    END
    \$do\$;
EOSQL