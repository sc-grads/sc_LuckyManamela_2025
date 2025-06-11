-- Create Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'TimesheetDB')
BEGIN
    CREATE DATABASE TimesheetDB;
END
GO

-- Use the database
USE TimesheetDB;
GO

-- Create Consultant table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Consultant')
BEGIN
    CREATE TABLE Consultant (
        ConsultantID INT IDENTITY(1,1) PRIMARY KEY,
        ConsultantName NVARCHAR(100) NOT NULL,
    );
END
GO

-- Create Client table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Client')
BEGIN
    CREATE TABLE Client (
        ClientID INT IDENTITY(1,1) PRIMARY KEY,
        ClientName NVARCHAR(100) NOT NULL Unique
    );
END
GO

-- Create Timesheet table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Timesheet')
BEGIN
    CREATE TABLE Timesheet (
        TimesheetID INT IDENTITY(1,1) PRIMARY KEY,
        ConsultantID INT NOT NULL,
        ClientID INT NOT NULL,
        EntryDate DATE NOT NULL,
        DayOfWeek NVARCHAR(10),
        Description NVARCHAR(500),
        BillableStatus NVARCHAR(20) NOT NULL,
        Comments NVARCHAR(1000),
        TotalHours TIME(0) NOT NULL,
        StartTime TIME(0),
        EndTime TIME(0),
        CONSTRAINT CHK_BillableStatus CHECK (BillableStatus IN ('Billable', 'Non-Billable')),
        CONSTRAINT CHK_TotalHours CHECK (TotalHours >= '00:00:00'),
        FOREIGN KEY (ConsultantID) REFERENCES Consultant(ConsultantID),
        FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    );
END
GO

-- Create Leave table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Leave')
BEGIN
    CREATE TABLE Leave (
        LeaveID INT IDENTITY(1,1) PRIMARY KEY,
        ConsultantID INT NOT NULL,
        TypeOfLeave NVARCHAR(50),
        StartDate DATE NOT NULL,
        EndDate DATE NOT NULL,
        NumberOfDays DECIMAL(5,2) NOT NULL,
        ApprovalObtained NVARCHAR(50) NOT NULL,
        SickNote NVARCHAR(20) NULL,
        Comments NVARCHAR(1000),
        CONSTRAINT CHK_NumberOfDays CHECK (NumberOfDays >= 0),
        FOREIGN KEY (ConsultantID) REFERENCES Consultant(ConsultantID)
    );
END
GO

-- Create TimesheetMetadata table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TimesheetMetadata')
BEGIN
    CREATE TABLE TimesheetMetadata (
        MetadataID INT IDENTITY(1,1) PRIMARY KEY,
        ConsultantID INT NOT NULL,
        DateFrom DATE NOT NULL,
        DateTo DATE NOT NULL,
        EmployeeSignature NVARCHAR(100),
        ClientSignature NVARCHAR(100),
        FOREIGN KEY (ConsultantID) REFERENCES Consultant(ConsultantID)
    );
END
GO

-- Create AuditLog table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'AuditLog')
BEGIN
    CREATE TABLE AuditLog (
        AuditID INT IDENTITY(1,1) PRIMARY KEY,
        TableName NVARCHAR(50) NOT NULL,
		FileName NVARCHAR(1000),
		EmployeeID INT,
		UserName NVARCHAR(50) NULL,
		Details NVARCHAR(MAX),
		Timestamp DATETIME NULL DEFAULT GETDATE()
      
    );
END
GO

-- Create ErrorLog table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ErrorLog')
BEGIN
    CREATE TABLE ErrorLog (
        ErrorID INT IDENTITY(1,1) PRIMARY KEY,
        FilePath NVARCHAR(1000),
        ErrorCode NVARCHAR(MAX),
        ErrorMessage NVARCHAR(1000),
        Timestamp DATETIME DEFAULT GETDATE()
    );
END
GO

-- Create Indexes
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Timesheet_ConsultantID_EntryDate')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Timesheet_ConsultantID_EntryDate
    ON Timesheet (ConsultantID, EntryDate)
    INCLUDE (TotalHours, BillableStatus);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Timesheet_ClientID')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Timesheet_ClientID
    ON Timesheet (ClientID);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Leave_ConsultantID_StartDate')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Leave_ConsultantID_StartDate
    ON Leave (ConsultantID, StartDate)
    INCLUDE (TypeOfLeave, NumberOfDays);
END
GO

-- Create Audit Trigger for Timesheet
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE name = 'tr_Timesheet_Audit')
BEGIN
    EXEC sp_executesql N'
    CREATE TRIGGER tr_Timesheet_Audit
    ON Timesheet
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        SET NOCOUNT ON;

        INSERT INTO AuditLog (TableName, FileName, EmployeeID, Details, Timestamp, UserName)
        SELECT
            ''Timesheet'',
            NULL, -- FileName will populated via SSIS parameter
            COALESCE(i.ConsultantID, d.ConsultantID), -- Map to ConsultantID
            (
                SELECT 
                    ''Old'' AS Action,
                    d.TimesheetID, d.ConsultantID, d.ClientID, d.EntryDate, d.DayOfWeek, d.Description, 
                    d.BillableStatus, d.Comments, d.TotalHours, d.StartTime, d.EndTime
                FOR JSON PATH, INCLUDE_NULL_VALUES
            ) + CASE 
                    WHEN EXISTS (SELECT 1 FROM inserted) THEN
                        '', '' + (
                            SELECT 
                                ''New'' AS Action,
                                i.TimesheetID, i.ConsultantID, i.ClientID, i.EntryDate, i.DayOfWeek, i.Description, 
                                i.BillableStatus, i.Comments, i.TotalHours, i.StartTime, i.EndTime
                            FOR JSON PATH, INCLUDE_NULL_VALUES
                        )
                    ELSE ''''
                END AS Details,
            GETDATE(),
            SYSTEM_USER
        FROM inserted i
        FULL OUTER JOIN deleted d ON i.TimesheetID = d.TimesheetID
        WHERE i.TimesheetID IS NOT NULL OR d.TimesheetID IS NOT NULL;
    END';
END
GO

-- Create Audit Trigger for Leave
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE name = 'tr_Leave_Audit')
BEGIN
    EXEC sp_executesql N'
    CREATE TRIGGER tr_Leave_Audit
    ON Leave
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        SET NOCOUNT ON;

        INSERT INTO AuditLog (TableName, FileName, EmployeeID, Details, Timestamp, UserName)
        SELECT
            ''Leave'',
            NULL, -- FileName will be populated via SSIS parameter
            COALESCE(i.ConsultantID, d.ConsultantID), -- Map to ConsultantID
            (
                SELECT 
                    ''Old'' AS Action,
                    d.LeaveID, d.ConsultantID, d.TypeOfLeave, d.StartDate, d.EndDate, d.NumberOfDays, 
                    d.ApprovalObtained, d.SickNote, d.Comments
                FOR JSON PATH, INCLUDE_NULL_VALUES
            ) + CASE 
                    WHEN EXISTS (SELECT 1 FROM inserted) THEN
                        '', '' + (
                            SELECT 
                                ''New'' AS Action,
                                i.LeaveID, i.ConsultantID, i.TypeOfLeave, i.StartDate, i.EndDate, i.NumberOfDays, 
                                i.ApprovalObtained, i.SickNote, i.Comments
                            FOR JSON PATH, INCLUDE_NULL_VALUES
                        )
                    ELSE ''''
                END AS Details,
            GETDATE(),
            SYSTEM_USER
        FROM inserted i
        FULL OUTER JOIN deleted d ON i.LeaveID = d.LeaveID
        WHERE i.LeaveID IS NOT NULL OR d.LeaveID IS NOT NULL;
    END';
END
GO

/*
-- Add triggers or computed columns to enforce HH:MM format (optional)
-- Note: DATETIME cannot be natively limited to HH:MM, so we use a trigger to validate
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE name = 'tr_Timesheet_TimeFormat')
BEGIN
    EXEC sp_executesql N'
    CREATE TRIGGER tr_Timesheet_TimeFormat
    ON Timesheet
    INSTEAD OF INSERT, UPDATE
    AS
    BEGIN
        SET NOCOUNT ON;
        INSERT INTO Timesheet (ConsultantID, ClientID, EntryDate, DayOfWeek, Description, BillableStatus, Comments, TotalHours, StartTime, EndTime)
        SELECT 
            i.ConsultantID,
            i.ClientID,
            i.EntryDate,
            i.DayOfWeek,
            i.Description,
            i.BillableStatus,
            i.Comments,
            i.TotalHours,
            CASE 
                WHEN i.StartTime IS NOT NULL 
                THEN DATEADD(ms, -DATEPART(ms, i.StartTime), DATEADD(ss, -DATEPART(ss, i.StartTime), i.StartTime))
                ELSE NULL 
            END,
            CASE 
                WHEN i.EndTime IS NOT NULL 
                THEN DATEADD(ms, -DATEPART(ms, i.EndTime), DATEADD(ss, -DATEPART(ss, i.EndTime), i.EndTime))
                ELSE NULL 
            END
        FROM inserted i
        -- Validate that StartTime and EndTime, if provided, are on the default date (1900-01-01) with HH:MM
        WHERE (i.StartTime IS NULL OR CAST(i.StartTime AS TIME) = i.StartTime)
          AND (i.EndTime IS NULL OR CAST(i.EndTime AS TIME) = i.EndTime)
          AND NOT EXISTS (
              SELECT 1 
              FROM Timesheet t 
              WHERE t.ConsultantID = i.ConsultantID 
                AND t.EntryDate = i.EntryDate 
                AND t.StartTime = i.StartTime 
                AND t.EndTime = i.EndTime
                AND t.TimesheetID != COALESCE((SELECT MAX(TimesheetID) FROM inserted), 0)
          );
        IF @@ROWCOUNT = 0
            INSERT INTO ErrorLog (FilePath, ErrorMessage, Timestamp)
            VALUES ('Trigger Validation', 'Invalid time format or duplicate entry for StartTime and EndTime', GETDATE());
    END';
END
GO*/
