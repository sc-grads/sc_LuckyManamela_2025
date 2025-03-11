-- Deleting a specific customer 
SELECT *
FROM Sales.Customer
GO


DELETE FROM Sales.Customer
WHERE CustomerID = 1; -- This deletes the customer added in the INSERT step
