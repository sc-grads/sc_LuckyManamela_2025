-- Creating an SQL Server login using SQL Server authentication

CREATE LOGIN MySQLLogin
WITH PASSWORD = 'LuckyManams@1000';
GO

-- Create a Windows login (domain user)
CREATE LOGIN [MyUser] FROM WINDOWS;
GO
