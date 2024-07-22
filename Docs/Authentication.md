# Authentication Model

### PostgreSQL Authentication Methods

PostgreSQL provides several authentication methods that can be configured in the `pg_hba.conf` file:

1. **Trust:**
    - No password required. Only use this method for local, trusted connections.
    
    ```
    local   all             all                                     trust
    
    ```
    
2. **Password:**
    - Password-based authentication. Supports both plain text and encrypted passwords.
    
    ```
    host    all             all             0.0.0.0/0               password
    
    ```
    
3. **MD5:**
    - Encrypted password authentication using MD5 hashing.
    
    ```
    host    all             all             0.0.0.0/0               md5
    
    ```
    
4. **Peer:**
    - Uses the operating system user name to authenticate. Only works for local connections.
    
    ```
    local   all             all                                     peer
    
    ```
    
5. **GSSAPI:**
    - Uses Kerberos for authentication.
    
    ```
    host    all             all             0.0.0.0/0               gss
    
    ```
    

### Configuring Authentication

1. **Edit `pg_hba.conf`:**
    - Located at `/var/lib/pgsql/13/data/` on Oracle Linux or `/etc/postgresql/13/main/` on Ubuntu
    - Add or modify lines to configure the desired authentication method:
    
    ```
    # Example: Using MD5 authentication for all connections
    host    all             all             0.0.0.0/0               md5
    
    ```
    
2. **Reload PostgreSQL Configuration:**
    
    ```bash
    sudo systemctl reload postgresql-13  # Oracle Linux
    sudo systemctl reload postgresql     # Ubuntu
    
    ```
    

### Setting User Passwords

1. **Set Password for a PostgreSQL User:**
    
    ```bash
    sudo -u postgres psql
    \\password username
    
    ```
    
    - Replace `username` with the actual PostgreSQL user name.
2. **Set Password Using SQL:**
    
    ```sql
    ALTER USER username WITH PASSWORD 'newpassword';
    
    ```
    
    - Replace `username` and `newpassword` with the actual PostgreSQL user name and the desired password.

By configuring the `pg_hba.conf` file and setting strong passwords for your PostgreSQL users, you can enhance the security of your database.