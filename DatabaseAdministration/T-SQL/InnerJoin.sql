-- Join SportTeams and SportGoals on TeamID = Team
SELECT 
    SportTeams.TeamID, 
    SportTeams.TeamName, 
    SportGoals.Goals, 
    SportGoals.Points
FROM SportTeams
INNER JOIN SportGoals
    ON SportTeams.TeamID = SportGoals.Team;
GO
