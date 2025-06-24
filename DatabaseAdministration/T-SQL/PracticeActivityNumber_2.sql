--Creating a table called tblPrimeNumbers with one column (intField)
CREATE TABLE tblPrimeNumbers (
    intField INT
);
GO

--Inserting a prime number values into the table as separate records
INSERT INTO tblPrimeNumbers (intField) VALUES (2);  
INSERT INTO tblPrimeNumbers (intField) VALUES (3);  
INSERT INTO tblPrimeNumbers (intField) VALUES (5);  
INSERT INTO tblPrimeNumbers (intField) VALUES (7);  
INSERT INTO tblPrimeNumbers (intField) VALUES (11);
GO

--Viewing the data in the table
SELECT * FROM tblPrimeNumbers;
GO

--Removing all the data from the table
DELETE FROM tblPrimeNumbers;
GO

--Deleting the table itself
DROP TABLE tblPrimeNumbers;
GO
