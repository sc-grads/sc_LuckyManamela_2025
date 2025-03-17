/*Creating a new database named MyTestDB
This database uses a primary filegroup for the main data file,an additional filegroup for large tables or indexes
and a dedicated transaction log file.*/

CREATE DATABASE MyTestDB
ON PRIMARY 
(
    NAME = 'MyTestDB_Data',                  -- Logical name for the primary data file
    FILENAME = 'C:\SQLDB\MyTestDB_Data.mdf', -- Physical file path for the primary data file
    SIZE = 100MB,                              -- Initial size of the data file
    MAXSIZE = 1024MB,                          -- Maximum allowable size for the data file
    FILEGROWTH = 10MB                          -- Auto-growth increment for the data file
),
FILEGROUP MySecondaryGroup                   -- Define an additional filegroup
(
    NAME = 'MyTestDB_Secondary',             -- Logical name for the secondary data file
    FILENAME = 'C:\SQLDB\MyTestDB_Secondary.ndf', -- Physical file path for the secondary data file
    SIZE = 100MB,                              -- Initial size of the secondary data file
    MAXSIZE = 1024MB,                          -- Maximum allowable size for the secondary file
    FILEGROWTH = 10MB                          -- Auto-growth increment for the secondary file
)
LOG ON
(
    NAME = 'MyDatabase_Log',                   -- Logical name for the transaction log file
    FILENAME = 'C:\SQLDB\MyTestDB_Log.ldf',	   -- Physical file path for the log file
    SIZE = 50MB,                               -- Initial size of the log file
    MAXSIZE = 512MB,                           -- Maximum allowable size for the log file
    FILEGROWTH = 5MB                           -- Auto-growth increment for the log file
);
GO
