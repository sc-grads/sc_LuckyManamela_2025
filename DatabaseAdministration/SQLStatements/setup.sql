-- Create the database
CREATE DATABASE AutoTest;
GO
USE AutoTest;
GO

-- Create the user table with 3 fields
CREATE TABLE [user] (
    Name NVARCHAR(50),
    Surname NVARCHAR(50),
    Email NVARCHAR(100)
);
GO

-- Create a stored procedure to insert data
CREATE PROCEDURE sp_InsertUser
    @Name NVARCHAR(50),
    @Surname NVARCHAR(50),
    @Email NVARCHAR(100)
AS
BEGIN
    INSERT INTO [user] (Name, Surname, Email)
    VALUES (@Name, @Surname, @Email);
END;
GO

-- Create a SQL Server login and user with full access
CREATE LOGIN Auto_user WITH PASSWORD = 'LuckyManamela@$2000';
GO
CREATE USER Auto_user FOR LOGIN Auto_user;
GO
ALTER ROLE db_owner ADD MEMBER Auto_user;
GO
