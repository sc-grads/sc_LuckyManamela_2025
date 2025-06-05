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
        Email NVARCHAR(100) UNIQUE,
        LineManager NVARCHAR(100),
        AddressDuringLeave NVARCHAR(500),
        PhoneDuringLeave NVARCHAR(50)
    );
END
GO

-- Create Client table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Client')
BEGIN
    CREATE TABLE Client (
        ClientID INT IDENTITY(1,1) PRIMARY KEY,
        ClientName NVARCHAR(100) NOT NULL
    );
END
GO

-- Create Project table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Project')
BEGIN
    CREATE TABLE Project (
        ProjectID INT IDENTITY(1,1) PRIMARY KEY,
        ClientID INT NOT NULL,
        ProjectName NVARCHAR(100),
        FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
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
        ProjectID INT NULL,
        EntryDate DATE NOT NULL,
        DayOfWeek NVARCHAR(10),
        Description NVARCHAR(500),
        BillableStatus NVARCHAR(20) NOT NULL,
        Comments NVARCHAR(1000),
        TotalHours TIME NOT NULL,
        StartTime TIME,
        EndTime TIME,
        CONSTRAINT CHK_BillableStatus CHECK (BillableStatus IN ('Billable', 'Non-Billable')),
        CONSTRAINT CHK_TotalHours CHECK (TotalHours >= '00:00:00'),
        FOREIGN KEY (ConsultantID) REFERENCES Consultant(ConsultantID),
        FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
        FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
    );
END
GO

-- Create Leave table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Leave')
BEGIN
    CREATE TABLE Leave (
        LeaveID INT IDENTITY(1,1) PRIMARY KEY,
        ConsultantID INT NOT NULL,
        TypeOfLeave NVARCHAR(50) NOT NULL,
        StartDate DATE NOT NULL,
        EndDate DATE NOT NULL,
        NumberOfDays DECIMAL(5,2) NOT NULL,
        ApprovalObtained BIT NOT NULL,
        SickNote BIT NOT NULL,
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
        Operation NVARCHAR(10) NOT NULL,
        RecordID INT NOT NULL,
        OldValue NVARCHAR(MAX),
        NewValue NVARCHAR(MAX),
        ChangeDate DATETIME NOT NULL,
        TBUser NVARCHAR(100)
    );
END
GO

-- Create ErrorLog table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ErrorLog')
BEGIN
    CREATE TABLE ErrorLog (
        ErrorID INT IDENTITY(1,1) PRIMARY KEY,
        FilePath NVARCHAR(255),
        SheetName NVARCHAR(100),
        RowData NVARCHAR(MAX),
        ErrorMessage NVARCHAR(1000),
        ErrorDate DATETIME NOT NULL
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
        INSERT INTO AuditLog (TableName, Operation, RecordID, OldValue, NewValue, ChangeDate, TBUser)
        SELECT
            ''Timesheet'',
            CASE WHEN EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) THEN ''UPDATE''
                 WHEN EXISTS (SELECT * FROM inserted) THEN ''INSERT''
                 ELSE ''DELETE'' END,
            COALESCE(i.TimesheetID, d.TimesheetID),
            (SELECT TotalHours, Description, BillableStatus FROM deleted FOR JSON PATH),
            (SELECT TotalHours, Description, BillableStatus FROM inserted FOR JSON PATH),
            GETDATE(),
            SYSTEM_USER
        FROM inserted i
        FULL OUTER JOIN deleted d ON i.TimesheetID = d.TimesheetID;
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
        INSERT INTO AuditLog (TableName, Operation, RecordID, OldValue, NewValue, ChangeDate, TBUser)
        SELECT
            ''Leave'',
            CASE WHEN EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) THEN ''UPDATE''
                 WHEN EXISTS (SELECT * FROM inserted) THEN ''INSERT''
                 ELSE ''DELETE'' END,
            COALESCE(i.LeaveID, d.LeaveID),
            (SELECT TypeOfLeave, StartDate, EndDate, NumberOfDays FROM deleted FOR JSON PATH),
            (SELECT TypeOfLeave, StartDate, EndDate, NumberOfDays FROM inserted FOR JSON PATH),
            GETDATE(),
            SYSTEM_USER
        FROM inserted i
        FULL OUTER JOIN deleted d ON i.LeaveID = d.LeaveID;
    END';
END
GO
