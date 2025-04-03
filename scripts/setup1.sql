BEGIN TRY
    -- 1. Create the database if it doesn't exist.
    IF DB_ID('AutoDBLuckyManamela') IS NULL
    BEGIN
        CREATE DATABASE [AutoDBLuckyManamela];
        PRINT 'Database created successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Database already exists.';
    END;

    -- 2. Switch context to the newly created or existing database.
    USE [AutoDBLuckyManamela];

    -- 3. Create the [User] table if it doesn't exist.
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE [name] = 'User'
          AND [schema_id] = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [dbo].[User] (
            [Name]    VARCHAR(50) NOT NULL,
            [Surname] VARCHAR(50) NOT NULL,
            [Email]   VARCHAR(100) NOT NULL
        );
        PRINT 'User table created successfully.';
    END
    ELSE
    BEGIN
        PRINT 'User table already exists.';
    END;

    -- 4. Create the stored procedure if it doesn't exist.
    IF NOT EXISTS (
        SELECT 1
        FROM sys.procedures
        WHERE [name] = 'InsertUserData'
          AND [schema_id] = SCHEMA_ID('dbo')
    )
    BEGIN
        EXEC('
            CREATE PROCEDURE [dbo].[InsertUserData]
                @Name    VARCHAR(50),
                @Surname VARCHAR(50),
                @Email   VARCHAR(100)
            AS
            BEGIN
                INSERT INTO [dbo].[User] ([Name], [Surname], [Email])
                VALUES (@Name, @Surname, @Email);
            END;
        ');
        PRINT 'InsertUserData procedure created successfully.';
    END
    ELSE
    BEGIN
        PRINT 'InsertUserData procedure already exists.';
    END;

    -- 5. Insert sample data.
    EXEC [dbo].[InsertUserData] @Name = 'Lucky',    @Surname = 'Manamela', @Email = 'lucky.manamela@sambeconsulting.com';
    EXEC [dbo].[InsertUserData] @Name = 'Itumeleng', @Surname = 'Monyai',   @Email = 'itumeleng.monyai@sambeconsulting.com';
    PRINT 'Sample data inserted successfully.';

END TRY
BEGIN CATCH
    DECLARE @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorSeverity INT           = ERROR_SEVERITY();
    DECLARE @ErrorState    INT           = ERROR_STATE();

    PRINT 'Error occurred: ' + @ErrorMessage;
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
GO
