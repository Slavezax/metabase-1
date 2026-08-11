#!/bin/bash
# Reproducible Metabase launcher (identical env to the pre-v0.63 setup)
cd /Users/administrator/Documents/GitHub/metabase
export JAVA_HOME=/opt/homebrew/Cellar/openjdk/25/libexec/openjdk.jdk/Contents/Home
export MB_DB_TYPE=postgres MB_DB_HOST=localhost MB_DB_PORT=5432 MB_DB_DBNAME=metabase MB_DB_USER=administrator
export MB_JETTY_HOST=0.0.0.0 MB_JETTY_PORT=3001 MB_JDBC_MAX_CONNECTION_POOL_SIZE=25 MB_LOG_LEVEL=INFO
export MB_PASSWORD_LENGTH=6 MB_PASSWORD_COMPLEXITY=normal
exec "$JAVA_HOME/bin/java" -jar target/uberjar/metabase.jar
