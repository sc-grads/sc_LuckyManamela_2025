--Creating a Simple Job to Execute a T-SQL Script
-- Creating a job named 'DailyBackupJob'
EXEC msdb.dbo.sp_add_job
    @job_name = 'DailyBackupJob',
    @enabled = 1,  -- Enable the job
    @description = 'Performs daily backup of the AdventureWorks2016 database';
GO

-- Add a job step that runs a backup command
EXEC msdb.dbo.sp_add_jobstep
    @job_name = 'DailyBackupJob',
    @step_name = 'BackupStep',
    @subsystem = 'TSQL',
    @command = N'BACKUP DATABASE AdventureWorks2016 TO DISK = ''C:\SQLDB\SQLBackups\AdventureWorks2016.bak'' WITH INIT;',
    @retry_attempts = 3,
    @retry_interval = 5;
GO

-- Create a schedule for the job (runs daily at 2 AM)
EXEC msdb.dbo.sp_add_schedule
    @schedule_name = 'Daily2AMSchedule',
    @freq_type = 2,  -- Daily frequency
    @active_start_time = 020000;  -- 02:00:00 AM
GO

-- Attach the schedule to the job
EXEC msdb.dbo.sp_attach_schedule
    @job_name = 'DailyBackupJob',
    @schedule_name = 'Daily2AMSchedule';
GO

-- Add the job to SQL Server Agent
EXEC msdb.dbo.sp_add_jobserver
    @job_name = 'DailyBackupJob';
GO
