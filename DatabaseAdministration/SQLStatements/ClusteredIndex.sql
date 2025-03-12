-- Create a clustered index on OrderDate in SalesOrderHeader
CREATE CLUSTERED INDEX IX_SalesOrderHeader_OrderDate
ON Sales.SalesOrderHeader (OrderDate);
