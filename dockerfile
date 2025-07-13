FROM postgres:16

# Instalar dependências necessárias para compilar extensões
RUN apt-get update && apt-get install -y \
    build-essential \
    libgeos-dev \
    libproj-dev \
    libprotobuf-c-dev \
    protobuf-c-compiler \
    && rm -rf /var/lib/apt/lists/*

# Criar diretório para extensões personalizadas
RUN mkdir -p /usr/local/share/postgresql/extension

# Clonar o repositório do PostgreSQL (ajuste a versão conforme necessário)
RUN git clone https://github.com/postgres/postgres.git /usr/src/postgres && \
    cd /usr/src/postgres && \
    git checkout REL_16_STABLE

# Compilar e instalar a extensão vector
RUN cd /usr/src/postgres/contrib/vector && \
    make && \
    make install

# Copiar a extensão compilada para o diretório de extensões do PostgreSQL
RUN cp /usr/src/postgres/contrib/vector/vector.control /usr/local/share/postgresql/extension/ && \
    cp /usr/src/postgres/contrib/vector/vector--1.0.sql /usr/local/share/postgresql/extension/

# Expor a porta do PostgreSQL
EXPOSE 5432

# Criar diretório de dados do PostgreSQL
ENV PGDATA /var/lib/postgresql/data/pgdata

# Definir usuário e grupo do PostgreSQL
USER postgres

# Iniciar o PostgreSQL
CMD ["postgres"]
