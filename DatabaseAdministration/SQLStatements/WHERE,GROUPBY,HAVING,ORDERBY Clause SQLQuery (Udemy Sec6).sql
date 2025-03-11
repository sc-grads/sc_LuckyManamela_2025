--Accessing everything from the Person.Address tbl
SELECT *
FROM Person.Address
GO

--Accessing everything from the Person.Address tbl where postal code 98011
SELECT *
FROM Person.Address
WHERE PostalCode = '98011'

--Accessing everything from the Person.Address tbl where postal code is not 98011
SELECT *
FROM Person.Address
WHERE PostalCode != '98011'