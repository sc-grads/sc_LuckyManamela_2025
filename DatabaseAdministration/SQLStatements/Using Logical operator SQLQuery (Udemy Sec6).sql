--Accessing information where the start date is 2013-05-30 00:00:00.000
SELECT *
FROM [Production].[ProductCostHistory]
WHERE StartDate = '2013-05-30 00:00:00.0'
GO

--Accessing information where the start date is 2013-05-30 00:00:00.000 and Standard Cost is greater than 200
SELECT *
FROM [Production].[ProductCostHistory]
WHERE StartDate = '2013-05-30 00:00:00.0' AND StandardCost >= 200.00
GO

--Accessing information where the start date is 2013-05-30 00:00:00.000 and Standard Cost is greater than 200 or ProductID > 800
SELECT *
FROM [Production].[ProductCostHistory]
WHERE (StartDate = '2013-05-30 00:00:00.0' AND StandardCost >= 200.00) OR ProductID > 800 --Note that we introduced Braces now so that the where statement can be excuted first and to make in my code
/* Note that the above code might show ProductID's that are lessthan 800 and that is because they meet the where clause requirements */


