--Denying Permissions

-- Deny DELETE permission on the Sales.SalesOrderHeader table to the SalesReaders role
DENY DELETE ON Sales.SalesOrderHeader TO SalesReaders;
GO
