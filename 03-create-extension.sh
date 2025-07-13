#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname chatwoot_nestor <<-EOSQL
  CREATE EXTENSION IF NOT EXISTS vector;
EOSQL
