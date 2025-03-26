-- Create the database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoTest')
BEGIN
    CREATE DATABASE AutoTest;
END
GO

-- Switch to the AutoTest database
USE AutoTest;
GO

-- Create the user table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'user')
BEGIN
    CREATE TABLE [user] (
        Name VARCHAR(50),
        Surname VARCHAR(50),
        Email VARCHAR(100)
    );
END
GO

-- Create a stored procedure to insert data
IF NOT EXISTS (SELECT * FROM sys.procedures WHERE name = 'InsertUserData')
BEGIN
    EXEC('
        CREATE PROCEDURE InsertUserData
            @Name VARCHAR(50),
            @Surname VARCHAR(50),
            @Email VARCHAR(100)
        AS
        BEGIN
            INSERT INTO [user] (Name, Surname, Email)
            VALUES (@Name, @Surname, @Email);
        END
    ');
END
GO

-- Execute the stored procedure to insert sample data
EXEC InsertUserData @Name = 'John', @Surname = 'Doe', @Email = 'john.doe@example.com';
EXEC InsertUserData @Name = 'Jane', @Surname = 'Smith', @Email = 'jane.smith@example.com';
GO
