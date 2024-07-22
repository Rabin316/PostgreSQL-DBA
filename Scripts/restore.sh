#!/bin/bash

# Set these variables
BACKUP_FILE="/path/to/your/backup/file.sql"
DATABASE_NAME="yourdatabase"
PGUSER="yourusername"
PGPASSWORD="yourpassword"

# Export PGPASSWORD for the duration of the script
export PGPASSWORD=$PGPASSWORD

# Drop the existing database (optional) and create a new one
dropdb -U $PGUSER $DATABASE_NAME
createdb -U $PGUSER $DATABASE_NAME

# Restore the backup
pg_restore -U $PGUSER -d $DATABASE_NAME -v $BACKUP_FILE

# Check if the restore was successful
if [ $? -eq 0 ]; then
  echo "Restore successful: $BACKUP_FILE"
else
  echo "Restore failed!"
  exit 1
fi

# Unset PGPASSWORD
unset PGPASSWORD
