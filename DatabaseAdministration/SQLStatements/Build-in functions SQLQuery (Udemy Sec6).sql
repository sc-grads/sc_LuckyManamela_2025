/*Functions in SQL are reusable database objects that perform a specific task and return a value. 
They are typically used to encapsulate logic that can be reused in queries.*/

-- Geting Full Names and Performing String Operations
SELECT 
    BusinessEntityID, 
    FirstName + ' ' + LastName AS FullName,  -- Concatenating first and last name
    UPPER(LastName) AS UpperLastName,       -- Converting last name to uppercase
    LOWER(FirstName) AS LowerFirstName,     -- Converting first name to lowercase
    LEN(FirstName) AS NameLength,           -- Getting the length of first name
    SUBSTRING(FirstName, 1, 3) AS FirstThreeLetters -- Extracting the first 3 letters of first name
FROM Person.Person;

--Advanced String Functions
--Extracting Domain from Email and Format Employee Names
SELECT 
    p.BusinessEntityID,  -- Explicitly specify table alias for BusinessEntityID
    e.EmailAddress,
    CHARINDEX('@', e.EmailAddress) AS AtPosition,  -- Find position of '@' in email
    RIGHT(e.EmailAddress, LEN(e.EmailAddress) - CHARINDEX('@', e.EmailAddress)) AS EmailDomain, -- Extract domain
    CONCAT(UPPER(LEFT(p.FirstName,1)), LOWER(SUBSTRING(p.FirstName, 2, LEN(p.FirstName)))) AS ProperCaseFirstName -- Capitalize first letter of FirstName
FROM Person.EmailAddress e  -- Assign alias 'e' to EmailAddress table
JOIN Person.Person p  -- Assign alias 'p' to Person table
ON e.BusinessEntityID = p.BusinessEntityID;



--Mathematical Functions
--Calculating Discounted Prices and Rounding

SELECT
    ProductID, 
    Name, 
    ListPrice, 
    ROUND(ListPrice * 0.9, 2) AS DiscountedPrice, -- Apply a 10% discount and round to 2 decimal places
    CEILING(ListPrice) AS RoundedUpPrice,        -- Round up to the nearest whole number
    FLOOR(ListPrice) AS RoundedDownPrice,        -- Round down to the nearest whole number
    ABS(ListPrice - 500) AS DifferenceFrom500    -- Get absolute difference from 500
FROM Production.Product;
/* Explanation:

CHARINDEX('@', EmailAddress): Finds the position of @ in an email.
RIGHT(EmailAddress, LEN(EmailAddress) - CHARINDEX('@', EmailAddress)): Extracts the domain.
CONCAT(UPPER(LEFT(FirstName,1)), LOWER(SUBSTRING(FirstName, 2, LEN(FirstName)))): Capitalizes the first letter of the first name.*/

--Advanced Mathematical Functions
--Employee Salary Analysis
SELECT 
    BusinessEntityID, 
    Rate AS BaseSalary, 
    POWER(Rate, 2) AS SalarySquared,   -- Square the salary
    LOG(Rate) AS LogSalary,            -- Natural logarithm of salary
    SQRT(Rate) AS SalaryRoot,          -- Square root of salary
    RAND() AS RandomValue              -- Generate a random number
FROM HumanResources.EmployeePayHistory;
/* Explanation:

POWER(Rate, 2): Computes the square of the salary.
LOG(Rate): Computes the natural logarithm of salary.
SQRT(Rate): Computes the square root of the salary.
RAND(): Generates a random number.*/


--Date and Time Functions
--Extracting Year, Month, and Calculating Date Differences
SELECT 
    SalesOrderID, 
    OrderDate, 
    YEAR(OrderDate) AS OrderYear,    -- Extract the year from OrderDate
    MONTH(OrderDate) AS OrderMonth,  -- Extract the month from OrderDate
    DAY(OrderDate) AS OrderDay,      -- Extract the day from OrderDate
    DATEDIFF(DAY, OrderDate, GETDATE()) AS DaysSinceOrder -- Number of days since the order was placed
FROM Sales.SalesOrderHeader;
--Advanced Date and Time Functions
--Employee Hire Date and Time Difference Analysis
SELECT 
    BusinessEntityID, 
    HireDate, 
    EOMONTH(HireDate) AS EndOfMonthHire,  -- Get the last day of the hire month
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsSinceHire, -- Years since hired
    DATEADD(YEAR, 5, HireDate) AS FiveYearsLater -- Adds 5 years to the hire date
FROM HumanResources.Employee;
/*EOMONTH(HireDate): Finds the last day of the month for the hire date.
DATEDIFF(YEAR, HireDate, GETDATE()): Calculates the number of years since hiring.
DATEADD(YEAR, 5, HireDate): Adds 5 years to the hire date.*/



--Aggregate Functions
--Total Orders, Sum, Average, and Maximum Order Value
SELECT 
    CustomerID, 
    COUNT(SalesOrderID) AS TotalOrders, -- Count total number of orders per customer
    SUM(TotalDue) AS TotalSales,       -- Calculate total sales per customer
    AVG(TotalDue) AS AvgOrderValue,    -- Calculate average order value per customer
    MAX(TotalDue) AS MaxOrderValue     -- Find the highest order value per customer
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;
--Advanced Aggregate Functions with GROUPING SETS
--Sales Summary with Multiple Groupings
SELECT 
    CustomerID, 
    YEAR(OrderDate) AS OrderYear, 
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY GROUPING SETS ((CustomerID), (YEAR(OrderDate)), (CustomerID, YEAR(OrderDate)), ());
/*Explanation:

GROUPING SETS: Computes multiple levels of aggregation:
Total sales per customer
Total sales per year
Total sales per customer and year
Grand total*/


--Conversion Functions
--Convert Money to String Format
SELECT 
    ProductID, 
    Name, 
    ListPrice, 
    CAST(ListPrice AS VARCHAR(50)) AS PriceAsString, -- Convert ListPrice to a string
    CONVERT(VARCHAR, ListPrice, 1) AS PriceFormatted -- Convert ListPrice using format style 1
FROM Production.Product;
--Advanced Conversion Functions
--Convert Data Types and Handle NULL Values
SELECT 
    ProductID, 
    Name, 
    CAST(ListPrice AS DECIMAL(10,2)) AS PriceDecimal,   -- Convert to decimal format
    FORMAT(ListPrice, 'C', 'en-US') AS PriceFormatted,  -- Convert to currency format
    COALESCE(NULLIF(Name, ''), 'No Name Available') AS ProductNameHandled -- Handle NULL and empty values
FROM Production.Product;
/*Explanation:

CAST(ListPrice AS DECIMAL(10,2)): Converts price to decimal with 2 decimal places.
FORMAT(ListPrice, 'C', 'en-US'): Formats the price as currency.
COALESCE(NULLIF(Name, ''), 'No Name Available'): Replaces NULL or empty string with 'No Name Available'.*/

--Ranking Functions
--Rank Employees by Salary
SELECT 
    BusinessEntityID,  
    Rate, 
    RANK() OVER (ORDER BY Rate DESC) AS SalaryRank,      -- Rank employees by salary, allowing duplicate ranks
    DENSE_RANK() OVER (ORDER BY Rate DESC) AS DenseRank, -- Rank employees without skipping numbers
    ROW_NUMBER() OVER (ORDER BY Rate DESC) AS RowNumber  -- Assign a unique row number to each employee
FROM HumanResources.EmployeePayHistory;

--Advanced Window Functions
--Running Total and Moving Averages
SELECT 
    SalesOrderID, 
    CustomerID, 
    OrderDate, 
    TotalDue,
    SUM(TotalDue) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RunningTotal, -- Running total per customer
    AVG(TotalDue) OVER (PARTITION BY CustomerID ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAverage -- 3-order moving average
FROM Sales.SalesOrderHeader;
/* Explanation:

SUM(TotalDue) OVER (PARTITION BY CustomerID ORDER BY OrderDate): Computes a running total per customer.
AVG(TotalDue) OVER (...) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW: Computes a 3-order moving average.*/


--System Functions
--Get Current User and Database Information
SELECT 
    SYSTEM_USER AS CurrentUser,  -- Get the current logged-in user
    DB_NAME() AS CurrentDatabase, -- Get the name of the current database
    HOST_NAME() AS HostMachine   -- Get the name of the machine running the SQL Server instance

--Advanced System Functions
--Retrieve SQL Server Metadata
SELECT 
    DB_NAME() AS DatabaseName,    -- Get the current database name
    SERVERPROPERTY('ProductVersion') AS SQLServerVersion, -- SQL Server version
    SESSION_USER AS CurrentUser,  -- Get the current SQL user
    HOST_NAME() AS ClientMachine, -- Get the machine name
    OBJECT_NAME(OBJECT_ID('Sales.SalesOrderHeader')) AS TableName -- Get table name from Object ID
/* Explanation:

DB_NAME(): Retrieves the current database name.
SERVERPROPERTY('ProductVersion'): Retrieves the SQL Server version.
SESSION_USER: Retrieves the current session user.
HOST_NAME(): Retrieves the machine name of the client.
OBJECT_NAME(OBJECT_ID('Sales.SalesOrderHeader')): Converts an object ID to a table name.*/



