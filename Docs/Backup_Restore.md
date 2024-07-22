# Backup and Restore

## Logical Backup

### pg_dump

The `pg_dump` utility is used for logical backups. It creates a script file or other archive file with SQL commands that can be used to reconstruct the database.

1. **Backup an Entire Database:**
    
    ```bash
    sudo -u postgres pg_dump database_name > /path/to/backup.sql
    
    ```
    
2. **Backup All Databases:**
    
    ```bash
    sudo -u postgres pg_dumpall > /path/to/backup.sql
    
    ```
    

### pg_restore

The `pg_restore` utility is used to restore the backup taken by `pg_dump`.

1. **Restore a Database:**
    
    ```bash
    sudo -u postgres createdb database_name
    sudo -u postgres pg_restore -d database_name /path/to/backup_file
    
    ```
    

### psql

The `psql` utility can also be used to restore backups created with `pg_dump` or `pg_dumpall`.

1. **Restore from SQL Backup:**
    
    ```bash
    sudo -u postgres psql -d database_name -f /path/to/backup.sql
    
    ```
    

## Physical Backup

### pg_basebackup

The `pg_basebackup` utility is used for physical backups. It copies the entire data directory of the PostgreSQL server.

1. **Create a Physical Backup:**
    
    ```bash
    sudo -u postgres pg_basebackup -D /path/to/backup_directory -Fp -Xs -P -v
    
    ```
    

### rsync

The `rsync` utility can be used to create a physical backup by synchronizing the data directory with a backup directory.

1. **Create a Physical Backup with rsync:**
    
    ```bash
    sudo rsync -av --delete /var/lib/pgsql/13/data/ /path/to/backup_directory/
    
    ```
    

### WAL Archiving

WAL (Write-Ahead Logging) archiving can be used to ensure continuous backup and point-in-time recovery.

1. **Configure WAL Archiving in `postgresql.conf`:**
    
    ```sql
    archive_mode = on
    archive_command = 'cp %p /path/to/archive/%f'
    
    ```
    
2. **Restore from WAL Archives:**
    - Use `recovery.conf` to specify the location of archived WAL files.
    
    ```bash
    restore_command = 'cp /path/to/archive/%f %p'
    
    ```
    

By using both logical and physical backup methods, you can ensure that your PostgreSQL databases are well-protected and can be restored in various scenarios.

## Restore

### Restore from Backup

1. **Restore from a Full Backup:**
    
    ```bash
    sudo -u postgres psql -f /path/to/backup.sql
    
    ```
    
2. **Restore a Specific Database:**
    
    ```bash
    sudo -u postgres createdb database_name
    sudo -u postgres psql database_name < /path/to/backup.sql
    
    ```
    