DECLARE @execution_id BIGINT;

EXEC SSISDB.catalog.create_execution
    @package_name=N'TimeSheetMigration 1.dtsx',
    @execution_id=@execution_id OUTPUT,
    @folder_name=N'NewDataMigration',
    @project_name=N'TimesheetMigration',
    @use32bitruntime=False,
    @reference_id=NULL;

EXEC SSISDB.catalog.start_execution @execution_id;
