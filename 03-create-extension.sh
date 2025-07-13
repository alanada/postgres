#!/bin/bash
set -e

# Espera o Postgres iniciar
until pg_isready -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER"; do
  echo "Esperando o Postgres iniciar..."
  sleep 2
done

# Cria extensão no banco chatwoot_nestor
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname chatwoot_nestor <<-EOSQL
  CREATE EXTENSION IF NOT EXISTS vector;
EOSQL

# Roda as migrations do Rails
bundle exec rails db:migrate

# Executa o comando padrão do container (ex: rails server)
exec "$@"
