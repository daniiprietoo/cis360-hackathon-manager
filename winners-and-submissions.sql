SELECT 
    h.HackathonID,
    h.Title AS HackathonTitle,
    w.TeamID,
    t.TeamName,
    w.SubmissionID,
    s.GitHubLink,
    w.Position,
    (SELECT CONCAT(u.FirstName, ' ', u.LastName)
     FROM Users u
     WHERE u.UserID = t.LeaderID) AS TeamLeader,
	(SELECT AVG(e.Score)
	 FROM Evaluations e
	 WHERE e.SubmissionID = w.SubmissionID) AS Score
FROM Winners w
JOIN Teams t ON w.TeamID = t.TeamID
JOIN Submissions s ON w.SubmissionID = s.SubmissionID
JOIN Hackathons h ON s.HackathonID = h.HackathonID
ORDER BY h.HackathonID, w.Position;
