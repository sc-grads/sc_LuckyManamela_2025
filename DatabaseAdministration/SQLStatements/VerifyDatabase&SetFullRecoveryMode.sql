USE master;
-- Check if AdventureWorks2016 is restored and verify its recovery model
SELECT name, state_desc, recovery_model_desc 
FROM sys.databases
WHERE name = 'AdventureWorks2016';

-- Set the database to Full Recovery Mode (required for Log Shipping and Replication)
ALTER DATABASE AdventureWorks2016 SET RECOVERY FULL;
