-- Practice Activity Number 4: Mathematical Functions and Safe Conversion

-- 1. Fix the calculation by performing decimal division using CAST
PRINT '1. Fixing integer division by converting to FLOAT';
SELECT system_type_id, column_id,
       CAST(system_type_id AS FLOAT) / column_id AS Calculation
FROM sys.all_columns;
GO

-- 2. Round down the decimal result to the nearest whole number using FLOOR
PRINT '2. Rounding down using FLOOR';
SELECT system_type_id, column_id,
       FLOOR(CAST(system_type_id AS FLOAT) / column_id) AS Calculation
FROM sys.all_columns;
GO

-- 3. Round up the decimal result to the nearest whole number using CEILING
PRINT '3. Rounding up using CEILING';
SELECT system_type_id, column_id,
       CEILING(CAST(system_type_id AS FLOAT) / column_id) AS Calculation
FROM sys.all_columns;
GO

-- 4. Round the decimal result to 1 decimal place using ROUND
PRINT '4. Rounding to one decimal place using ROUND';
SELECT system_type_id, column_id,
       ROUND(CAST(system_type_id AS FLOAT) / column_id, 1) AS Calculation
FROM sys.all_columns;
GO

-- 5. Multiply system_type_id by 2 and safely convert to TINYINT using TRY_CAST
-- Values above 255 will return NULL instead of an error
PRINT '5. Multiplying system_type_id by 2 and safely converting to TINYINT using TRY_CAST';
SELECT system_type_id,
       TRY_CAST(system_type_id * 2 AS TINYINT) AS TinyValue
FROM sys.all_columns;
GO
