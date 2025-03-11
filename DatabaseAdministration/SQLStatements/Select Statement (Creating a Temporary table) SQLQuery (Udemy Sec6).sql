/*Selecting BusinessEntityID,FirstName,LastName and Title 
from the Person.Person Table where Tittle is equl to mr.*/

SELECT BusinessEntityID,FirstName,LastName, Title
FROM Person.Person
WHERE Title = 'mr.'

--Creating a temporary table table to store the information
SELECT BusinessEntityID,FirstName,LastName, Title
INTO #TempPersonTBL
FROM Person.Person
WHERE Title = 'mr.'

--Selecting everything from the TempPersonTBL 
SELECT *
FROM #TempPersonTBL

--Droping the table #TempPersonTBL (Note that Temp table are only available till the session end)
DROP TABLE #TempPersonTBL

--Using the create statement to create a temporary table 
CREATE TABLE #TempPersonTable(
BusinesEntityID INT,
FirstName NVARCHAR(50),
LastName NVARCHAR(50),
)

--Inserting details from the Person table int the temporary table 
INSERT INTO #TempPersonTable
SELECT BusinessEntityID,FirstName,LastName
FROM Person.Person
WHERE Title = 'mr.'