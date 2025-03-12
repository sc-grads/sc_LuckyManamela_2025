/*Triggers in SQL Server automatically execute in response to INSERT, UPDATE, or DELETE operations on a table. 
Below, I’ll provide examples of basic triggers and advanced triggers in the AdventureWorks2016 database.*/

-- Create an audit table to log new orders
CREATE TABLE Sales.SalesOrderAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    SalesOrderID INT,
    CustomerID INT,
    OrderDate DATETIME,
    TotalDue MONEY,
    ActionTaken VARCHAR(50),
    ActionTime DATETIME DEFAULT GETDATE()
);

-- Create an AFTER INSERT trigger to log new orders
CREATE TRIGGER trg_AfterInsertSalesOrder
ON Sales.SalesOrderHeader
AFTER INSERT
AS
BEGIN
    -- Insert only non-computed values, but read TotalDue (which is computed)
    INSERT INTO Sales.SalesOrderAudit (SalesOrderID, CustomerID, OrderDate, TotalDue, ActionTaken, ActionTime)
    SELECT SalesOrderID, CustomerID, OrderDate, TotalDue, 'INSERT', GETDATE()
    FROM inserted;
END;
GO


-- Insert a new order by providing CustomerID, OrderDate, DueDate, BillToAddressID, and ShipToAddressID
INSERT INTO Sales.SalesOrderHeader (CustomerID, OrderDate, DueDate, BillToAddressID, ShipToAddressID)
VALUES (100, GETDATE(), DATEADD(day, 7, GETDATE()), 1, 1);




-- Check the audit log
SELECT * FROM Sales.SalesOrderAudit;



