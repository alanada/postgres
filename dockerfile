FROM postgres:14
COPY setup-pgvector.sh /setup-pgvector.sh
RUN chmod +x /setup-pgvector.sh && /setup-pgvector.sh && \
    apt-get remove -y build-essential git postgresql-server-dev-14 && apt-get autoremove -y
