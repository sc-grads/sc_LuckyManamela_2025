-- Retrievin customers who have placed more than 5 orders using a subquery
SELECT CustomerID, 
       (SELECT COUNT(*) 
        FROM Sales.SalesOrderHeader 
        WHERE Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID) AS OrderCount
FROM Sales.Customer
WHERE CustomerID IN 
    (SELECT CustomerID FROM Sales.SalesOrderHeader 
     GROUP BY CustomerID 
     HAVING COUNT(SalesOrderID) > 5); -- Subquery filters customers with more than 5 orders
