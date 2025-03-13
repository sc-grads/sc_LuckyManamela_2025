CREATE DATABASE TestDB
GO

ALTER DATABASE TESTDB SET MIXED_PAGE_ALLOCATION ON --By default ms create uniform pages but here i am changing it to mixed pages

--Creating a heap table, not that a heap table i sa table that does not have indexes
CREATE TABLE Heaptbl (c1 INT, c2 VARCHAR(8000))
INSERT INTO Heaptbl VALUES (1,REPLICATE('a',1000))

SELECT * FROM Heaptbl

--DROP TABLE Heaptbl

SELECT
    ht1.c1,
    ht1.c2,
    p.file_id,
    p.page_id,
    dddpa.is_mixed_page_allocation
FROM
    Heaptbl AS ht1
CROSS APPLY
    sys.fn_PhysLocCracker(%%physloc%%) AS p
INNER JOIN
    sys.dm_db_database_page_allocation(
        DB_ID(),
        OBJECT_ID('dbo.heaptable1'),
        NULL,
        NULL,
        'detailed'
    ) AS dddpa
ON
    p.file_id = dddpa.allocated_page_file_id
    AND p.page_id = dddpa.allocated_page_page_id;

-- Enable trace flag
DBCC TRACEON(3604, -1);
-- Display page information
DBCC PAGE(TestDB, 1, 1, 3);


