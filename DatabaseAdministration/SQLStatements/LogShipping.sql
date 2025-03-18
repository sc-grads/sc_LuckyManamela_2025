--Configuring Log Shipping

-- Log Shipping involves:
-- 1. Backing up the transaction log from the primary database.
-- 2. Copying the log backup to the secondary server.
-- 3. Restoring the log backup on the secondary server.

--Back up transaction log (run on primary server)
BACKUP LOG AdventureWorks2016 TO DISK = 'C:\Backup\AW_LogBackup.trn';
GO

--Restore the transaction log on a secondary server (run on secondary server)
RESTORE LOG AdventureWorks2016 
FROM DISK = 'C:\Backup\AW_LogBackup.trn'
WITH NORECOVERY;
GO
