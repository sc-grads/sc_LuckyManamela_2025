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

--Date and Time Functions

