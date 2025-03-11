--Accessing information where enddate is not null 
SELECT *
FROM [Production].[ProductCostHistory]
WHERE EndDate is not NULL
GO
--Accessing information where enddate is null 
SELECT *
FROM [Production].[ProductCostHistory]
WHERE EndDate IS NULL