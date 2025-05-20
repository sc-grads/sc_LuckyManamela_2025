-- Practice Activity Number 5: String Manipulation with sys.all_columns

-- 1. Select all column names
SELECT [name]
FROM sys.all_columns;
GO

-- 2. Add the letter 'A' to the end of each name using string concatenation
PRINT '1. Adding the letter A to the end of each name';
SELECT [name], [name] + 'A' AS NameWithA
FROM sys.all_columns;
GO

-- 3. Add the Unicode character 'A' (A with a stroke) to the end
-- Since [name] is VARCHAR, we convert it to NVARCHAR to support Unicode
PRINT '2. Adding the Unicode character A to the end of each name';
SELECT [name], CAST([name] AS NVARCHAR(256)) + N'A' AS NameWithUnicodeA
FROM sys.all_columns;
GO

-- 4. Remove the first character from the name using SUBSTRING
-- Start from position 2 to remove the first character
PRINT '3. Removing the first character from name';
SELECT [name], SUBSTRING([name], 2, LEN([name]) - 1) AS NameWithoutFirstChar
FROM sys.all_columns;
GO

-- 5. Remove the last character from the name
-- Use SUBSTRING from position 1 up to the length minus 1
PRINT '4. Removing the last character from name';
SELECT [name], SUBSTRING([name], 1, LEN([name]) - 1) AS NameWithoutLastChar
FROM sys.all_columns;
GO
