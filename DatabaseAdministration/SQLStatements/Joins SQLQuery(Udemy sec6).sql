-- Joining SalesOrderHeader with Customer and Person tables to retrieve full customer details along with order total
SELECT 
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    soh.SalesOrderID,
    soh.TotalDue
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
ORDER BY soh.TotalDue DESC; -- Order by highest total sales first


