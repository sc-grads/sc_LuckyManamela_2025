-- Version 1: Create a variable using SMALLINT and assign it a value of 20,000
DECLARE @myVar SMALLINT;
SET @myVar = 20000;
PRINT @myVar;
GO

-- Version 2: Try assigning a value of 200,000 to SMALLINT (This should fail)
DECLARE @myVar SMALLINT;
SET @myVar = 200000;  -- Will cause an overflow error
PRINT @myVar;
GO

-- Version 3: Use INT to store 200,000
DECLARE @myVar INT;
SET @myVar = 200000;
PRINT @myVar;
GO

-- Version 4: Use TINYINT and assign 20,000 (This should fail)
DECLARE @myVar TINYINT;
SET @myVar = 20000;  -- Will cause an overflow error
PRINT @myVar;
