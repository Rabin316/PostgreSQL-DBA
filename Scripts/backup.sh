#!/bin/bash

# Set these variables
BACKUP_DIR="/path/to/your/backup/directory"
DATABASE_NAME="yourdatabase"
PGUSER="yourusername"
PGPASSWORD="yourpassword"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Get the current date and time for the backup file name
TIMESTAMP=$(date +"%F_%T")
BACKUP_FILE="$BACKUP_DIR/$DATABASE_NAME-$TIMESTAMP.sql"

# Export PGPASSWORD for the duration of the script
export PGPASSWORD=$PGPASSWORD

# Perform the backup
pg_dump -U $PGUSER -F c -b -v -f $BACKUP_FILE $DATABASE_NAME

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup successful: $BACKUP_FILE"
else
  echo "Backup failed!"
  exit 1
fi

# Unset PGPASSWORD
unset PGPASSWORD
