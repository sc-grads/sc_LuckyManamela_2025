-- Summarise data and filter to only include groups with 4 or more rows
SELECT Attack, COUNT(*) AS NumberOfRows
FROM SportTeams
GROUP BY Attack
HAVING COUNT(*) >= 4
ORDER BY NumberOfRows DESC, Attack ASC;
GO
