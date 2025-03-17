--Restore to a Specific Point in Time (Restore in Time Lab)

-- Step 1: Restore the full backup of 'MyTestDB' with NORECOVERY.
-- NORECOVERY leaves the database in a restoring state so that additional log backups can be applied.
RESTORE DATABASE MyTestDB
FROM DISK = 'C:\SQLDB\SQLBackups\MyTestDB_Full.bak'
WITH NORECOVERY;
GO

-- Step 2: Restore the transaction log backup(s) up to the desired point in time.
RESTORE LOG MyTestDB
FROM DISK = 'C:\SQLDB\MyTestDB_Log.trn'
WITH STOPAT = '2025-03-17T10:30:00',  -- Specify the point in time for recovery.
     RECOVERY;                        -- RECOVERY brings the database online after applying the log backup.
GO
