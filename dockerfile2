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

# Clonar o repositório do PostgreSQL (se necessário)
# RUN git clone https://github.com/postgres/postgres.git /usr/src/postgres && \
#     cd /usr/src/postgres && \
#     git checkout REL_16_STABLE

# Instalar a extensão pgvector
RUN apt-get install -y postgresql-16-pgvector

# Expor a porta do PostgreSQL
EXPOSE 5432

# Definir usuário e grupo do PostgreSQL
USER postgres

# Iniciar o PostgreSQL
CMD ["postgres"]
