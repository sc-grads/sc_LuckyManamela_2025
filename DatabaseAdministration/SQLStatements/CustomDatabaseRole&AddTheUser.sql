--Custom Database Role and Add the User

USE AdventureWorks2016;
GO

-- Create a custom database role
CREATE ROLE SalesReaders;
GO

-- Add the database user 'TestUserDBUser' to the 'SalesReaders' role
EXEC sp_addrolemember 'SalesReaders', 'LuckyManamelaDBUs';
GO
