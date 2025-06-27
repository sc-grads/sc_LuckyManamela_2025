USE SSISDB;
GO

IF OBJECT_ID('dbo.RunSSISPackageWithRetries', 'P') IS NOT NULL
    DROP PROCEDURE dbo.RunSSISPackageWithRetries;
GO

CREATE PROCEDURE dbo.RunSSISPackageWithRetries
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @try INT = 1;
    DECLARE @max_tries INT = 3;
    DECLARE @execution_id BIGINT;
    DECLARE @execution_status INT;

    WHILE @try <= @max_tries
    BEGIN
        EXEC SSISDB.catalog.create_execution
            @package_name = N'TimeSheetMigration 1.dtsx',
            @execution_id = @execution_id OUTPUT,
            @folder_name = N'NewDataMigration',
            @project_name = N'TimesheetMigration',
            @use32bitruntime = 0,
            @reference_id = NULL;

        EXEC SSISDB.catalog.start_execution @execution_id;

        WAITFOR DELAY '00:00:10';

        -- Corrected status check here:
        SELECT @execution_status = operation_status
        FROM SSISDB.catalog.operation
        WHERE operation_id = @execution_id;

        IF @execution_status = 7 -- Succeeded
        BEGIN
            BREAK;
        END

        SET @try += 1;
    END

    IF @execution_status <> 7
    BEGIN
        THROW 50000, 'SSIS package failed after 3 attempts.', 1;
    END
END
GO
