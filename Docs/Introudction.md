# PostgreSQL DBA

# Introduction

Postgres Architecture

![Postgres Architecture](/Docs/Untitled.png)


Description

- **Client**:
    - Represents the end-user or application that interacts with the PostgreSQL database.
- **Postmaster**:
    - The primary daemon process in PostgreSQL responsible for accepting connections and starting new server processes to handle those connections.
- **Postgres**:
    - Also known as the backend process or server process, it handles the actual database operations like executing queries, reading from and writing to the disk, etc.
- **Archiver**:
    - A background process that handles the archiving of WAL (Write-Ahead Logging) files, ensuring that they are stored securely and can be used for point-in-time recovery.
- **Shared Buffer**:
    - The shared memory area used for caching data pages read from the disk to speed up read and write operations.
- **Other Buffers**:
    - Additional buffer areas within the shared memory for various other purposes.
- **CLOG Buffer**:
    - Stores commit log (CLOG) information, which keeps track of the commit status of transactions.
- **Wal Buffer**:
    - Temporary storage area for WAL data before it is written to disk, ensuring data integrity and durability.
- **Stats Collector**:
    - A background process that collects and logs various statistics about the database activity.
- **Checkpointer**:
    - A process responsible for writing all dirty pages (modified pages) from the shared buffer to disk at regular intervals to ensure data consistency.
- **Logging Collector**:
    - Collects and stores log messages from the various server processes to an external log file.
- **Wal Writer**:
    - A background process that periodically writes the contents of the WAL buffer to the WAL files on disk.
- **Writer**:
    - Writes dirty shared buffers to the disk when the buffer cache is under pressure and needs to make space for new pages.
- **Auto Vacuum Launcher**:
    - Manages the automatic vacuuming process to clean up dead tuples and maintain the health of the database.
- **Archive Logs**:
    - Stored on disk, these are the archived copies of WAL files used for backup and recovery purposes.
- **Wal Files**:
    - Write-Ahead Log files stored on disk, used to record all changes made to the database to ensure durability and data integrity.
- **Data Files**:
    - The actual files stored on disk containing the database's data.
- **Log Files**:
    - Files that store various log messages and error reports generated by the PostgreSQL server processes.