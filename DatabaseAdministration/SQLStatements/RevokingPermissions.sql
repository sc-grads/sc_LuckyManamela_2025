--Revoking Permissions
-- Revoke the previously granted SELECT permission from the SalesReaders role
REVOKE SELECT ON Sales.SalesOrderHeader FROM SalesReaders;
GO
