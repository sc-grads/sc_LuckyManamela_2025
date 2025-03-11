--Deeper understanding of the select statement
USE AdventureWorks2016 --Accessing the AdventureWorks DB
GO

--Accessing everything from the Person.Address tbl
SELECT *
FROM Person.Address

--Accessing only certain columns in the Person.Address tbl
SELECT AddressID,City,ModifiedDate --Note that the order in which you write the columns does not matter
From [Person].[Address]

--Filtering the data using top statement
SELECT TOP 10 * 
FROM [Person].[Address]

