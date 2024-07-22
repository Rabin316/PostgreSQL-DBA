# Streaming Replication for Oracle Linux 7.9

| Server 1 (Master Server)
 | Server 2 (Slave Server)
 |
| --- | --- |
| IP :  192.168.56.16
OS: Oracle Linux 7.9 | IP :  192.168.56.16
OS: Oracle Linux 7.9 |

## Setting Up Streaming Replication

### Master Server Configuration

1. **Edit `postgresql.conf`:**
    - Enable replication and set necessary parameters:
    
    ```sql
    listen_addresses = '*'
    wal_level = hot_standby
    archive_mode = on
    archive_command = 'cp %p /var/lib/pgsql/archive/%f'
    max_wal_senders = 3
    wal_keep_segments = 64
    
    ```
    
    Create the archive directory and set permissions.
    
    ```bash
    sudo mkdir -p /var/lib/pgsql/archive
    sudo chown postgres:postgres /var/lib/pgsql/archive
    ```
    
2. **Create a Replication User:**
    
    ```bash
    sudo -u postgres psql
    CREATE USER replicator REPLICATION LOGIN ENCRYPTED PASSWORD 'password';
    
    ```
    
3. **Edit `pg_hba.conf`:**
    - Allow replication connections from the slave server:
    
    ```sql
    host replication replicator 192.168.56.110/32 md5
    
    ```
    
4. Restart PostgreSQL Service
    
    ```bash
    systemctl restart postgresql
    ```
    

### Slave Server Configuration

1. **Stop PostgreSQL Service:**
    
    ```bash
    sudo systemctl stop postgresql # Oracle Linux
    
    ```
    
    Clear the existing data directory.
    
    ```bash
    sudo rm -rf /var/lib/pgsql/data/*
    mkdir -p /var/lib/pgsql/data/
    chown -R postgres:postgres /var/lib/pgsql/data/*
    chmod -R 700 /var/lib/pgsql/data/*
    ```
    
2. **Base Backup from Master:**
    
    ```bash
    sudo -u postgres pg_basebackup -h 192.168.56.16 -D /var/lib/pgsql/data -U replicator -v -P -X stream
    
    ```
    
3. **Create `recovery.conf` in Data Directory:**
    
    ```sql
    standby_mode = 'on'
    primary_conninfo = 'host=192.168.56.16 port=5432 user=replicator password=password'
    restore_command = 'cp /var/lib/pgsql/archive/%f %p'
    
    ```
    
    Change ownership of the `recovery.conf` file.
    
    ```
    sudo chown postgres:postgres /var/lib/pgsql/data/recovery.conf
    ```
    
4. **Start PostgreSQL Service:**
    
    ```bash
    sudo systemctl start postgresql # Oracle Linux
    
    ```
    

### Monitoring Replication

1. **Check Replication Status on Master:**
    
    ```bash
    sudo -u postgres psql -c "SELECT * FROM pg_stat_replication;"
    
    ```
    
2. **Check Replication Status on Slave:**
    
    ```bash
    sudo -u postgres psql -c "SELECT * FROM pg_stat_wal_receiver;"
    
    ```
    

By setting up streaming replication, you can ensure high availability and data redundancy for your PostgreSQL databases.

To properly shut down your PostgreSQL database, follow these steps:

### Using `pg_ctl` Command:

1. **Switch to the `postgres` User:**
If you're not already logged in as the `postgres` user, switch to it:
    
    ```
    sudo su - postgres
    
    ```
    
2. **Stop PostgreSQL using `pg_ctl`:**
Use the `pg_ctl` command with the `stop` option to shut down PostgreSQL:
    
    ```
    pg_ctl stop -D ${PGDATA}
    
    ```
    
    Replace `${PGDATA}` with the path to your PostgreSQL data directory. This command will gracefully stop the PostgreSQL server.
    
3. **Verify Shutdown:**
After issuing the shutdown command, verify that PostgreSQL has stopped by checking its status:
    
    ```
    pg_ctl status -D ${PGDATA}
    
    ```
    
    If PostgreSQL has successfully stopped, it should report that the server is not running.
    
4. **Exit from `postgres` User:**
Once confirmed that PostgreSQL is shut down, you can exit from the `postgres` user session:
    
    ```
    exit
    
    ```
    

### Using `systemctl` (Alternative Method):

Alternatively, you can use `systemctl` to stop the PostgreSQL service:

```
sudo systemctl stop postgresql

```

This command stops the PostgreSQL service managed by systemd. After issuing the command, verify the status to ensure PostgreSQL has stopped:

```
sudo systemctl status postgresql

```

To check any errors run following command

```bash
tail -f /var/lib/pgsql/data/pg_log/postgresql-*.log

```

# Streaming Replication for Ubuntu 20.4

[https://www.digitalocean.com/community/tutorials/how-to-set-up-physical-streaming-replication-with-postgresql-12-on-ubuntu-20-04](https://www.digitalocean.com/community/tutorials/how-to-set-up-physical-streaming-replication-with-postgresql-12-on-ubuntu-20-04)

```bash

###Streaming Replication (ubunutu)

for Ubunutu
---On Primary (Master)
listen_addresses = '*'
wal_level = hot_standby
archive_mode = on
archive_command = 'cp %p /var/lib/pgsql/archive/%f'
max_wal_senders = 3
min_wal_size=1GB
max_wal_size=2GB

sudo vi /etc/postgresql/16/main/postgresql.conf
sudo -u postgres psql
CREATE ROLE replicator WITH REPLICATION PASSWORD 'password' LOGIN;
\q
sudo vi /etc/postgresql/16/main/pg_hba.conf
systemctl restart postgresql

---Slave (Replica)
SHOW data_directory;
sudo -u postgres rm -r /var/lib/postgresql/16/main/*
sudo -u postgres rm -r /var/lib/postgresql/16/main
sudo -u postgres mkdir /var/lib/postgresql/16/main
sudo -u postgres chmod 700 /var/lib/postgresql/16/main
sudo -u postgres pg_basebackup -h primary-ip-addr -p 5432 -U replicator -D /var/lib/postgresql/16/main/ -Fp -Xs -R
systemctl restart postgresql
sudo -u postgres psql

---on master
SELECT client_addr, state FROM pg_stat_replication;
```

# Installation of Pgadmin

Follow Below Link

[https://www.pgadmin.org/download/](https://www.pgadmin.org/download/)