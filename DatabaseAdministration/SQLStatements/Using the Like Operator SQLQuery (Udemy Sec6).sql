--Accessing information where the FirstName Starts with MAT
SELECT *
FROM Person.Person
WHERE FirstName LIKE 'MAT%'
GO

--Accessing information where the FirstName ends with ew
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%ew' -- Take note that EW and ew is the same thing, MS SQl is not case sensetive


