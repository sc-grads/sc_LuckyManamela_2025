-- Create a stored procedure to get sales order details for a given CustomerID
CREATE PROCEDURE GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    -- Select all orders for the provided customer
    SELECT SalesOrderID, OrderDate, TotalDue
    FROM Sales.SalesOrderHeader
    WHERE CustomerID = @CustomerID
    ORDER BY OrderDate DESC; -- Show latest orders first
END;
GO

-- Executing the stored procedure for a specific customer
EXEC GetCustomerOrders @CustomerID = 100;
