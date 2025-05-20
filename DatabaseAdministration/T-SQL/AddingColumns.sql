-- Add a new column called Ranking of data type int
ALTER TABLE SportTeams
ADD Ranking int;
GO

-- View the updated table with the new column
SELECT * FROM SportTeams;
GO
