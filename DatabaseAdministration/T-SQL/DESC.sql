-- Summarise data and order by NumberOfRows descending, then Attack ascending
SELECT Attack, COUNT(*) AS NumberOfRows
FROM SportTeams
GROUP BY Attack
ORDER BY NumberOfRows DESC, Attack ASC;
GO
