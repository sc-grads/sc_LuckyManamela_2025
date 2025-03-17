--Creating a Database User
-- Switching to the target database
USE MyTestDB;
GO

-- Create a database user for the SQL Server login 'MySQLLogin'
CREATE USER MyDBUser FOR LOGIN MySQLLogin;
GO

-- Alternatively, create a user for a Windows login
CREATE USER [LuckyManamela] FOR LOGIN [SAMBE2025008\Lucky Kgalifi Maname];
GO
