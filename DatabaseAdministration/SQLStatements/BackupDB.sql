-- Creating a full backup of MyTestDB to a specified disk location.
/*The backup options used:
- FORMAT: Creates a new media set.
- INIT: Overwrites any existing backup sets in the file.
- NAME: Provides a friendly name for the backup set.*/

BACKUP DATABASE MyTestDB
TO DISK = 'C:\SQLDB\SQLBackups\MyTestDB_Full.bak'
WITH FORMAT, INIT, NAME = 'Full Backup of MyTestDB';
GO
