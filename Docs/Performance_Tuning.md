# Performance Tuning

### Shared Buffers

1. **Edit `postgresql.conf`:**
    - Location: `/var/lib/pgsql/13/data/` on Oracle Linux or `/etc/postgresql/13/main/` on Ubuntu
    - Set `shared_buffers` to a value suitable for your system:
    
    ```
    shared_buffers = 1GB
    
    ```
    

### Work Mem

1. **Edit `postgresql.conf`:**
    - Set `work_mem` to a value suitable for your system:
    
    ```
    work_mem = 64MB
    
    ```
    

### Maintenance Work Mem

1. **Edit `postgresql.conf`:**
    - Set `maintenance_work_mem` to a value suitable for your system:
    
    ```
    maintenance_work_mem = 256MB
    
    ```
    
2. **Restart PostgreSQL Service:**
    
    ```bash
    sudo systemctl restart postgresql-13  # Oracle Linux
    sudo systemctl restart postgresql     # Ubuntu
    
    ```
    