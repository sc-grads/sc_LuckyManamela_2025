-- Retrieving total sales per customer, grouping them, filtering customers with sales above 5000, and order by highest sales
SELECT CustomerID, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING SUM(TotalDue) > 5000 -- Only customers with total sales above 5000
ORDER BY TotalSales DESC; -- Sort in descending order (highest sales first)
