FROM postgres:14

# Instalar dependências e compilar o pgvector
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    postgresql-server-dev-14 && \
    git clone --branch v0.7.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && make && make install && cd .. && rm -rf pgvector && \
    apt-get remove -y git build-essential postgresql-server-dev-14 && apt-get autoremove -y

# Copia o script para criar a extensão
COPY init-data.sh /docker-entrypoint-initdb.d/init-data.sh

# Permissão de execução (boa prática)
RUN chmod +x /docker-entrypoint-initdb.d/init-data.sh
