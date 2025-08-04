Use Master
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
		CONSTRAINT UQ_Timesheet UNIQUE (ConsultantID, EntryDate, StartTime),
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

-- Drop the existing AuditLog if it exists (backup data if needed)
IF OBJECT_ID('AuditLog', 'U') IS NOT NULL
BEGIN
    DROP TABLE AuditLog;
END
GO
CREATE TABLE AuditLog (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    ConsultantID INT NOT NULL,
    ConsultantName NVARCHAR(100) NOT NULL,
    SubmissionMonth NVARCHAR(10) NOT NULL,
    SubmissionDate DATE NOT NULL,
    SubmissionTime TIME(0) NOT NULL,
    SubmissionType NVARCHAR(20) NOT NULL,
    ChangeType NVARCHAR(20) NULL,
    AffectedTable NVARCHAR(20) NULL,
    RecordCount INT NULL,
    AuditTimestamp DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ConsultantID) REFERENCES Consultant(ConsultantID),
    CONSTRAINT CHK_SubmissionType CHECK (SubmissionType IN ('Timesheet', 'Leave')),
    CONSTRAINT CHK_ChangeType CHECK (ChangeType IN ('Insert', 'Delete', 'Truncate', 'Drop') OR ChangeType IS NULL)
);
GO

ALTER TABLE AuditLog
ADD CONSTRAINT CHK_SubmissionMonth_Valid
CHECK (
    SubmissionMonth IN (
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
    )
);

-- Create ErrorLog table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ErrorLog')
BEGIN
    CREATE TABLE ErrorLog (
        ErrorID INT IDENTITY(1,1) PRIMARY KEY,
        FilePath NVARCHAR(1000),
        ErrorCode INT,
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


CREATE TRIGGER tr_Timesheet_Audit
ON Timesheet
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO AuditLog (ConsultantID, ConsultantName, SubmissionMonth, SubmissionDate, SubmissionTime, SubmissionType, ChangeType, AffectedTable, RecordCount)
        SELECT 
            i.ConsultantID,
            (SELECT ConsultantName FROM Consultant c WHERE c.ConsultantID = i.ConsultantID),
            DATENAME(month, i.EntryDate),
            CAST(GETDATE() AS DATE),
            CAST(GETDATE() AS TIME(0)),
            'Timesheet',
            'Insert',
            'Timesheet',
            @@ROWCOUNT
        FROM inserted i;
    END
    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO AuditLog (ConsultantID, ConsultantName, SubmissionMonth, SubmissionDate, SubmissionTime, SubmissionType, ChangeType, AffectedTable, RecordCount)
        SELECT 
            d.ConsultantID,
            (SELECT ConsultantName FROM Consultant c WHERE c.ConsultantID = d.ConsultantID),
            DATENAME(month, d.EntryDate),
            CAST(GETDATE() AS DATE),
            CAST(GETDATE() AS TIME(0)),
            'Timesheet',
            'Delete',
            'Timesheet',
            @@ROWCOUNT
        FROM deleted d;
    END
END;
GO

-- Drop existing trigger if it exists
IF OBJECT_ID('tr_Leave_Audit', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER tr_Leave_Audit;
END
GO

-- Create trigger for Leave table
CREATE TRIGGER tr_Leave_Audit
ON Leave
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO AuditLog (ConsultantID, ConsultantName, SubmissionMonth, SubmissionDate, SubmissionTime, SubmissionType, ChangeType, AffectedTable, RecordCount)
        SELECT 
            i.ConsultantID,
            (SELECT ConsultantName FROM Consultant c WHERE c.ConsultantID = i.ConsultantID),
            DATENAME(month, i.StartDate), -- Using StartDate as the reference month
            CAST(GETDATE() AS DATE),
            CAST(GETDATE() AS TIME(0)),
            'Leave',
            'Insert',
            'Leave',
            @@ROWCOUNT
        FROM inserted i;
    END
    IF EXISTS (SELECT 1 FROM deleted)
    BEGIN
        INSERT INTO AuditLog (ConsultantID, ConsultantName, SubmissionMonth, SubmissionDate, SubmissionTime, SubmissionType, ChangeType, AffectedTable, RecordCount)
        SELECT 
            d.ConsultantID,
            (SELECT ConsultantName FROM Consultant c WHERE c.ConsultantID = d.ConsultantID),
            DATENAME(month, d.StartDate), -- Using StartDate as the reference month
            CAST(GETDATE() AS DATE),
            CAST(GETDATE() AS TIME(0)),
            'Leave',
            'Delete',
            'Leave',
            @@ROWCOUNT
        FROM deleted d;
    END
END;
GO

--Enable Audit
/*USE master;
CREATE SERVER AUDIT Audit_SSISDB
TO FILE (FILEPATH = 'C:\Audits\')
WITH (QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE);
ALTER SERVER AUDIT Audit_SSISDB WITH (STATE = ON);
GO

CREATE DATABASE AUDIT SPECIFICATION Audit_Spec
FOR SERVER AUDIT Audit_SSISDB
ADD (SCHEMA_OBJECT_CHANGE_GROUP),
ADD (DATABASE_OBJECT_CHANGE_GROUP)
WITH (STATE = ON);
GO*/

