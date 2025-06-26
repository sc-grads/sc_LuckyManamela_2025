USE master;
GO

-- 1) Add existing login to sysadmin, if not already
IF NOT EXISTS (
    SELECT 1 
      FROM sys.server_role_members m
      JOIN sys.server_principals p 
        ON m.member_principal_id = p.principal_id
     WHERE p.name = 'LuckyManamela'
       AND m.role_principal_id = 
           (SELECT principal_id 
              FROM sys.server_principals 
             WHERE name = 'sysadmin')
)
BEGIN
    ALTER SERVER ROLE sysadmin 
        ADD MEMBER [LuckyManamela];
    PRINT 'Added LuckyManamela to sysadmin';
END
ELSE
    PRINT 'LuckyManamela is already a sysadmin member';
GO

-- 2) (Optional) Create a user in YourDatabase, if you need one
USE TimesheetDB;   -- <-- change to your target database
GO

IF NOT EXISTS (
    SELECT 1 
      FROM sys.database_principals 
     WHERE name = 'LuckyManamela'
)
BEGIN
    CREATE USER [LuckyManamela] 
        FOR LOGIN [LuckyManamela];
    PRINT 'Created database user LuckyManamela';
    
    -- e.g. grant db_owner (or any other role) if desired:
    ALTER ROLE db_owner 
        ADD MEMBER [LuckyManamela];
    PRINT 'Added LuckyManamela to db_owner';
END
ELSE
    PRINT 'Database user LuckyManamela already exists';
GO

