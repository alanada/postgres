FROM postgres:16
COPY setup-pgvector.sh /setup-pgvector.sh
RUN chmod +x /setup-pgvector.sh && /setup-pgvector.sh && \
    apt-get remove -y build-essential git postgresql-server-dev-16 && apt-get autoremove -y
