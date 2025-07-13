FROM postgres:14

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    postgresql-server-dev-14 && \
    git clone --branch v0.7.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && make && make install && cd .. && rm -rf pgvector && \
    apt-get remove -y build-essential git postgresql-server-dev-14 && apt-get autoremove -y

COPY 01-create-database.sql /docker-entrypoint-initdb.d/
COPY 03-create-extension.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/03-create-extension.sh
