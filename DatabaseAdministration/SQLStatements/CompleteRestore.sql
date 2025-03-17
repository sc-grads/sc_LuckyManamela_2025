--Complete Restore

/*-Restoring the full backup of 'MyTestDB' from the backup file.
-WITH REPLACE allows the restore to overwrite the existing database.
-RECOVERY makes the database available for use immediately after the restore.*/

RESTORE DATABASE MyTestDB
FROM DISK = 'C:\SQLDB\SQLBackups\MyTestDB_Full.bak'
WITH REPLACE, RECOVERY;
GO
