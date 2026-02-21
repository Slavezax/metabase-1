#!/bin/bash
# Script to import Railway database backup into local PostgreSQL

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

echo "=== Database Import Script ==="
echo ""

# Check if backup file exists
if [ -f "metabase_backup.sql.gz" ]; then
    echo "✅ Found compressed backup: metabase_backup.sql.gz"
    echo "🔄 Decompressing backup file..."
    gunzip metabase_backup.sql.gz
    echo "✅ Decompressed to metabase_backup.sql"
elif [ -f "metabase_backup.sql" ]; then
    echo "✅ Found metabase_backup.sql"
else
    echo "❌ Error: metabase_backup.sql not found!"
    echo "Please run the backup process first using ./backup-railway-db.sh"
    echo "Looking for either metabase_backup.sql or metabase_backup.sql.gz"
    exit 1
fi
echo ""

# Check PostgreSQL connection
echo "🔍 Testing PostgreSQL connection..."
if ! psql -d metabase -c '\q' 2>/dev/null; then
    echo "❌ Cannot connect to local PostgreSQL database 'metabase'"
    echo "Make sure PostgreSQL is running: brew services start postgresql@15"
    exit 1
fi

echo "✅ PostgreSQL connection successful"
echo ""

# Clear existing data (if any)
echo "🗑️  Clearing existing metabase database data..."
psql -d metabase -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"

# Import the backup
echo "📥 Importing backup data..."
psql -d metabase -f metabase_backup.sql

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Database import completed successfully!"
    echo ""
    echo "You can now start Metabase with:"
    echo "  ./metabase-config.sh"
    echo ""
else
    echo ""
    echo "❌ Database import failed!"
    exit 1
fi
