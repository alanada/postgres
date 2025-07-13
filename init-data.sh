#!/bin/bash
set -e

POSTGRES_USER="dpostgres"
POSTGRES_DB="dpostgres"

apt-get update && apt-get install -y \
  build-essential \
  git \
  postgresql-server-dev-14

git clone --branch v0.7.0 https://github.com/pgvector/pgvector.git
cd pgvector
make && make install
cd ..
rm -rf pgvector

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS vector;
EOSQL
