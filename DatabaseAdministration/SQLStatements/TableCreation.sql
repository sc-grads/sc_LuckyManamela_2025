-- Creating a table named 'MyTable' within the MyTestDB
-- Placing the table on the secondary filegroup (MySecondaryGroup) to help distribute I/O load.
CREATE TABLE MyTable
(
    ID INT IDENTITY(1,1) PRIMARY KEY,  -- Primary key column with an auto-incrementing identity
    Name NVARCHAR(100),                -- Column to store names, up to 100 characters
    CreatedDate DATETIME DEFAULT GETDATE()  -- Column to store creation date, defaulting to the current date/time
)
ON MySecondaryGroup;  -- Specify the filegroup where the table's data will be stored
GO
