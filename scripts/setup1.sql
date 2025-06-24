IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoDBLuckyManamela')
BEGIN
    EXEC('CREATE DATABASE AutoDBLuckyManamela');
END
GO

USE AutoDBLuckyManamela;
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
            BEGIN TRY
                INSERT INTO [user] (Name, Surname, Email)
                VALUES (@Name, @Surname, @Email);
            END TRY
            BEGIN CATCH
                -- Retrieve error information and re-raise the error.
                DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
                SELECT 
                    @ErrorMessage = ERROR_MESSAGE(),
                    @ErrorSeverity = ERROR_SEVERITY(),
                    @ErrorState = ERROR_STATE();
                RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
            END CATCH
        END
    ');
END
GO

EXEC InsertUserData @Name = 'Lucky', @Surname = 'Manamela', @Email = 'lucky.manamela@sambeconsulting.com';
EXEC InsertUserData @Name = 'Thabang', @Surname = 'Mothapo', @Email = 'thabang.mothapo@sambeconsulting.com';
GO
