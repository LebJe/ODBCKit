#!/bin/zsh

# docker run -d \
# --name odbckit-mssql-server \
# -p 1433:1433 \
# -e ACCEPT_EULA=Y \
# -e SA_PASSWORD=mssqlODBCKit \
# mcr.microsoft.com/mssql/server:2019-latest

docker run -d \
--name odbckit-postgresql-server \
-p 5432:5432 \
-e POSTGRES_DB=odbckit \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=odbckitPostgres \
postgres:14-alpine
