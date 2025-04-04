BEGIN TRY
    ----------------------------------------------------------------------------
    -- 1. Create the database if it doesn't exist (On-Premise / SQL Server only)
    ----------------------------------------------------------------------------
    IF DB_ID('AutoDBLuckyManamela') IS NULL
    BEGIN
        CREATE DATABASE [AutoDBLuckyManamela];
        PRINT 'Database AutoDBLuckyManamela created successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Database AutoDBLuckyManamela already exists.';
    END;

    ----------------------------------------------------------------------------
    -- 2. Switch context to the target database
    ----------------------------------------------------------------------------
    -- Explicitly set the database context
    USE [AutoDBLuckyManamela];
    PRINT 'Switched context to AutoDBLuckyManamela.';

    ----------------------------------------------------------------------------
    -- 3. Create the [Users] table if it doesn't exist
    ----------------------------------------------------------------------------
    IF NOT EXISTS (
        SELECT 1
        FROM sys.tables
        WHERE [name] = 'Users'
          AND [schema_id] = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE TABLE [dbo].[Users] (
            [Name]       VARCHAR(50)  NOT NULL,
            [Surname]    VARCHAR(50)  NOT NULL,
            [Email]      VARCHAR(100) NOT NULL,
            [CreatedOn]  DATETIME     NOT NULL DEFAULT(GETDATE()),
            CONSTRAINT [PK_Users] PRIMARY KEY ([Email]) -- Added for uniqueness
        );
        PRINT 'Users table created successfully.';
    END
    ELSE
    BEGIN
        PRINT 'Users table already exists.';
    END;

    ----------------------------------------------------------------------------
    -- 4. Create the stored procedure if it doesn't exist
    ----------------------------------------------------------------------------
    IF NOT EXISTS (
        SELECT 1
        FROM sys.procedures
        WHERE [name] = 'InsertUserData'
          AND [schema_id] = SCHEMA_ID('dbo')
    )
    BEGIN
        CREATE PROCEDURE [dbo].[InsertUserData]
            @Name    VARCHAR(50),
            @Surname VARCHAR(50),
            @Email   VARCHAR(100)
        AS
        BEGIN
            SET NOCOUNT ON; -- Reduces unnecessary output
            INSERT INTO [dbo].[Users] ([Name], [Surname], [Email])
            VALUES (@Name, @Surname, @Email);
            PRINT 'Inserted user: ' + @Name + ' ' + @Surname + ', ' + @Email;
        END;
        PRINT 'InsertUserData procedure created successfully.';
    END
    ELSE
    BEGIN
        PRINT 'InsertUserData procedure already exists.';
    END;

    ----------------------------------------------------------------------------
    -- 5. Insert sample rows using the stored procedure
    ----------------------------------------------------------------------------
    -- Check if the sample data already exists to avoid duplicates
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [Email] = 'lucky.manamela@sambeconsulting.com')
    BEGIN
        EXEC [dbo].[InsertUserData] @Name = 'Lucky', @Surname = 'Manamela', @Email = 'lucky.manamela@sambeconsulting.com';
    END;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [Email] = 'itumeleng.monyai@sambeconsulting.com')
    BEGIN
        EXEC [dbo].[InsertUserData] @Name = 'Itumeleng', @Surname = 'Monyai', @Email = 'itumeleng.monyai@sambeconsulting.com';
    END;
    PRINT 'Sample data insertion attempted.';

END TRY
BEGIN CATCH
    ----------------------------------------------------------------------------
    -- 6. Handle errors
    ----------------------------------------------------------------------------
    DECLARE @ErrorMessage  NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorSeverity INT           = ERROR_SEVERITY();
    DECLARE @ErrorState    INT           = ERROR_STATE();

    -- Enhanced error reporting
    PRINT 'Error occurred:';
    PRINT 'Message: ' + @ErrorMessage;
    PRINT 'Severity: ' + CAST(@ErrorSeverity AS NVARCHAR(10));
    PRINT 'State: ' + CAST(@ErrorState AS NVARCHAR(10));
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;
