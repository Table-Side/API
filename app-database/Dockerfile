FROM postgres:16 AS database

# Copy .env file
COPY .env  /docker-entrypoint-initdb.d/.env
COPY .env  /.env

# Set workdir
WORKDIR /database

# Copy initialisation scripts
COPY /scripts/users.sh /docker-entrypoint-initdb.d/10-users.sh 
COPY /scripts/databases.sh /docker-entrypoint-initdb.d/20-databases.sh
