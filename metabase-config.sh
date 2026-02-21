#!/bin/bash
# Metabase Configuration Script

# Database Configuration for Local PostgreSQL
export MB_DB_TYPE=postgres
export MB_DB_DBNAME=metabase
export MB_DB_PORT=5432
export MB_DB_USER=administrator
export MB_DB_HOST=localhost

# Port Configuration (using 3001 as requested)  
export MB_JETTY_PORT=3001
export MB_JETTY_HOST=0.0.0.0

# Security Settings
export MB_PASSWORD_COMPLEXITY=normal
export MB_PASSWORD_LENGTH=6

# Logging
export MB_LOG_LEVEL=INFO

export MB_JDBC_MAX_CONNECTION_POOL_SIZE=25

echo "Metabase configuration loaded:"
echo "- Database: PostgreSQL on localhost:5432/metabase"
echo "- Web Port: $MB_JETTY_PORT"
echo "- User: $MB_DB_USER"

# Set Java path
export JAVA_HOME=/opt/homebrew/Cellar/openjdk/25/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

# Start Metabase
echo "Starting Metabase..."
java -jar target/uberjar/metabase.jar
