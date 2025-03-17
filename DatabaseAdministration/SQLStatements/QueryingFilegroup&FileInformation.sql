--Querying Filegroup and File Information

-- Retrieve detailed information about the filegroups and files for 'MyTestDB'
/*by joining system views. This query returns:
- Filegroup names.
- Logical and physical file names.
- File sizes, maximum sizes, and growth increments (converted to MB).*/

SELECT 
    fg.name AS FileGroupName,                -- Name of the filegroup
    mf.name AS LogicalFileName,              -- Logical name of the file
    mf.physical_name AS PhysicalFileName,    -- Physical path of the file on disk
    mf.size/128 AS SizeMB,                   -- File size in MB (each page is 8KB; dividing by 128 converts pages to MB)
    mf.max_size/128 AS MaxSizeMB,            -- Maximum file size in MB
    mf.growth/128 AS GrowthMB                -- Growth increment in MB
FROM sys.filegroups fg
INNER JOIN sys.master_files mf
    ON fg.data_space_id = mf.data_space_id  -- Join to relate filegroups with their files
WHERE mf.database_id = DB_ID('MyTestDB'); -- Filter results for 'MyTestDB'
GO
