-- Create a non-clustered index on CustomerID in SalesOrderHeader
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_CustomerID
ON Sales.SalesOrderHeader (CustomerID);
