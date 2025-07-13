#!/bin/bash
set -e;

# Instalar dependências para compilar o pgvector
apt-get update && apt-get install -y \
  build-essential \
  git \
  postgresql-server-dev-14

# Clonar e compilar o pgvector
git clone --branch v0.7.0 https://github.com/pgvector/pgvector.git
cd pgvector
make && make install
cd ..
rm -rf pgvector

# Criar a extensão no banco padrão
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS vector;
EOSQL
