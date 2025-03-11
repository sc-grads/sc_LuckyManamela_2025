--Accessing Employee pay history
SELECT *
FROM [HumanResources].[EmployeePayHistory]

--Access information about what is highest payment rate
SELECT MAX(Rate) AS HighestPayRate -- Note that HighestPayRate is an Alias
FROM [HumanResources].[EmployeePayHistory]

--Access information about what is lowest payment rate
SELECT MIN(Rate) AS LowestPayRate
FROM [HumanResources].[EmployeePayHistory]
