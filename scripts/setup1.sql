BEGIN TRY
    -- Create database if it doesn't exist
    IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoDBLuckyManamela')
    BEGIN
        EXEC('CREATE DATABASE AutoDBLuckyManamela');
        PRINT 'Database created successfully';
    END
    ELSE
    BEGIN
        PRINT 'Database already exists';
    END

    USE AutoDBLuckyManamela;

    -- Create table if it doesn't exist
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'user')
    BEGIN
        CREATE TABLE [user] (
            Name VARCHAR(50),
            Surname VARCHAR(50),
            Email VARCHAR(100)
        );
        PRINT 'User table created successfully';
    END
    ELSE
    BEGIN
        PRINT 'User table already exists';
    END

    -- Create procedure if it doesn't exist
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
        PRINT 'InsertUserData procedure created successfully';
    END
    ELSE
    BEGIN
        PRINT 'InsertUserData procedure already exists';
    END

    -- Insert sample data
    EXEC InsertUserData @Name = 'Lucky', @Surname = 'Manamela', @Email = 'lucky.manamela@sambeconsulting.com';
    EXEC InsertUserData @Name = 'Itumeleng', @Surname = 'Monyai', @Email = 'itumeleng.monyai@sambeconsulting..com';
    PRINT 'Sample data inserted successfully';

END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
    DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
    DECLARE @ErrorState INT = ERROR_STATE();

    PRINT 'Error occurred: ' + @ErrorMessage;
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO