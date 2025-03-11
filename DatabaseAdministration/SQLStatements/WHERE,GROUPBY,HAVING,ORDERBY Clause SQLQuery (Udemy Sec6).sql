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
--Alternative way to Access everything from the Person.Address tbl where postal code is not 98011
SELECT *
FROM Person.Address
WHERE PostalCode <> '98011'

-- Counting the number of postal address that does not have the NO 98011
SELECT COUNT(*)
FROM Person.Address
WHERE PostalCode <> '98011'

--Accessing information where the Modification date is greater or equals to 2013-05-30 00:00:00.000
SELECT *
FROM Person.Address
WHERE ModifiedDate >= '2013-05-30 00:00:00.000'

--Accessing information where the Modification date is lessthan or equals to 2013-05-30 00:00:00.000
SELECT *
FROM Person.Address
WHERE ModifiedDate <= '2013-05-30 00:00:00.000'



