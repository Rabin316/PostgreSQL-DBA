Installation and Configuration (Oracle Linux and Ubuntu)

Follow this website for postgresql  for related OS: 

[https://www.postgresql.org/download/](https://www.postgresql.org/download/)

### Oracle Linux 7 x86_64

1. **Update the System:**
    
    ```bash
    sudo yum update -y
    
    ```
    
2. **Install PostgreSQL:**
    
    ```bash
    # Install the repository RPM:
    sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
    
    # Install PostgreSQL:
    yum install postgresql-server
    ```
    
3. **Initialize the Database:**
    
    ```bash
     sudo postgresql-setup initdb
    ```
    
4. **Enable and Start PostgreSQL Service:**
    
    ```bash
    sudo systemctl start postgresql
    sudo systemctl enable postgresql
    
    ```
    

### Ubuntu

1. **Update the System:**
    
    ```bash
    sudo apt update
    sudo apt upgrade -y
    
    ```
    
2. **Install PostgreSQL:**
    
    ```bash
    sudo apt install postgresql 
    
    ```
    
3. **Enable and Start PostgreSQL Service:**
    
    ```bash
    sudo systemctl enable postgresql
    sudo systemctl start postgresql
    
    ```
    

### Configuration

1. **Edit `postgresql.conf`:**
    - Location: `/var/lib/pgsql/13/data/` on Oracle Linux or `/etc/postgresql/13/main/` on Ubuntu
    - Set `listen_addresses` to `'*'` to allow remote connections:
        
        ```
        listen_addresses = '*'
        
        ```
        
2. **Edit `pg_hba.conf`:**
    - Allow remote connections by adding the following line:
        
        ```
        host all all 0.0.0.0/0 md5
        
        ```
        
3. **Restart PostgreSQL Service:**
    
    ```bash
    sudo systemctl restart postgresql-13  # Oracle Linux
    sudo systemctl restart postgresql     # Ubuntu
    
    ```
    
4. **Set PostgreSQL Password:**
    
    ```bash
    sudo -u postgres psql
    \password postgres
    
    ```
    

This setup will allow you to install and configure PostgreSQL on both Oracle Linux and Ubuntu.