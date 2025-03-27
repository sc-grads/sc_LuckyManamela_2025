IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoDBLuckyManamela_27March2025')
BEGIN
    EXEC('CREATE DATABASE AutoDBLuckyManamela_27March2025');
END
GO

USE AutoDBLuckyManamela_27March2025;
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'user')
BEGIN
    CREATE TABLE [user] (
        Name VARCHAR(50),
        Surname VARCHAR(50),
        Email VARCHAR(100)
    );
END
GO

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

EXEC InsertUserData @Name = 'John', @Surname = 'Doe', @Email = 'john.doe@example.com';
EXEC InsertUserData @Name = 'Jane', @Surname = 'Smith', @Email = 'jane.smith@example.com';
GO
