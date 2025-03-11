-- Insert a new customer into the Customer table
INSERT INTO Sales.Customer (PersonID, StoreID, TerritoryID, ModifiedDate)
VALUES (NULL, NULL, 5,  GETDATE()); -- Using NULLs for optional columns and current date for ModifiedDate
