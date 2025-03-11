-- Update the SalesPersonID for a specific customer
SELECT * 
FROM Sales.Customer

UPDATE Sales.Customer
SET TerritoryID = 10 -- Assign to a different sales territory
WHERE CustomerID = 232; -- Make sure CustomerID exists before running
