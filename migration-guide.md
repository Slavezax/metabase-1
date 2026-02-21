# Metabase Migration Guide: Railway to Local

## Overview
This guide will help you migrate your Metabase instance and PostgreSQL database from Railway.com to your local machine.

## Prerequisites
✅ Local PostgreSQL 15 installed and running  
✅ Local Metabase development environment ready  
⏳ Database backup from Railway (see steps below)  

## Step 1: Backup Your Railway Database

Run the backup script we created for you:

```bash
./backup-railway-db.sh
```

This will give you detailed instructions. Here's a quick summary:

1. **Login to Railway:**
   ```bash
   railway login
   ```

2. **Connect to your database and create a backup:**
   ```bash
   railway ssh --project=4c060edd-949a-4d83-95ca-892b64b1356d --environment=8b189df9-aa8f-4f05-a5a4-85e443d66d36 --service=7955626a-881b-4138-9a56-97c544f07ee7
   ```

3. **Inside the Railway database container:**
   ```bash
   pg_dump -U $PGUSER -h $PGHOST -p $PGPORT -d $PGDATABASE --clean --no-owner --no-privileges > /tmp/metabase_backup.sql
   exit
   ```

4. **Copy the backup to your local machine:**
   ```bash
   railway ssh --project=4c060edd-949a-4d83-95ca-892b64b1356d --environment=8b189df9-aa8f-4f05-a5a4-85e443d66d36 --service=7955626a-881b-4138-9a56-97c544f07ee7 -- cat /tmp/metabase_backup.sql > metabase_backup.sql
   ```

## Step 2: Import Database to Local PostgreSQL

Once you have `metabase_backup.sql` in this directory, run:

```bash
./import-database.sh
```

This script will:
- Verify the backup file exists
- Test PostgreSQL connection
- Clear the existing metabase database
- Import your Railway data

## Step 3: Configure and Start Local Metabase

Since Metabase is already running in development mode, you'll need to:

1. **Stop the current Metabase process:**
   ```bash
   pkill -f "metabase"
   ```

2. **Start with the new configuration:**
   ```bash
   ./metabase-config.sh
   ```

   This will start Metabase on port 3001 (as requested) and connect to your local PostgreSQL database.

## Step 4: Access Your Migrated Metabase

Open your browser and go to: `http://localhost:3001`

Your Metabase should now be running locally with all your Railway data!

## Step 5: Clean Up Railway (Optional)

After verifying everything works locally, you can:

1. Delete your Railway services to stop billing
2. Remove the Railway project entirely

## Files Created

- `backup-railway-db.sh` - Script with backup instructions
- `import-database.sh` - Database import script  
- `metabase-config.sh` - Metabase startup script with local config
- `migration-guide.md` - This guide

## Configuration Details

Your local Metabase is configured with:
- **Port:** 3001 (as requested)
- **Database:** PostgreSQL on localhost:5432/metabase
- **User:** administrator (your local user)

## Troubleshooting

If you encounter issues:

1. **Database connection errors:** Make sure PostgreSQL is running:
   ```bash
   brew services start postgresql@15
   ```

2. **Port 3001 already in use:** The script will help identify what's using it

3. **Import fails:** Check that your backup file is valid and PostgreSQL is accessible

## Next Steps

After migration:
- Update any external integrations to point to your new local URL
- Consider setting up automatic backups
- Configure any custom settings that were specific to Railway

