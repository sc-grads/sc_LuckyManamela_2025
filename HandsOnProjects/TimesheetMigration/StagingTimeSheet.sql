USE TimesheetDB;
GO

IF OBJECT_ID('dbo.Staging_Timesheet', 'U') IS NOT NULL
    DROP TABLE dbo.Staging_Timesheet;
GO

CREATE TABLE dbo.Staging_Timesheet
(
    StagingID INT IDENTITY(1,1) NOT NULL,
    FilePath NVARCHAR(500) NOT NULL,
    SheetName NVARCHAR(100) NOT NULL,
    ConsultantName NVARCHAR(100),
    DateValue NVARCHAR(50),
    DayOfWeek NVARCHAR(50),
    Client NVARCHAR(100),
    StartTime NVARCHAR(50),
    EndTime NVARCHAR(50),
    IsProcessed BIT DEFAULT 0,
    ErrorMessage NVARCHAR(500),
    LoadDateTime DATETIME DEFAULT GETDATE()
);
GO