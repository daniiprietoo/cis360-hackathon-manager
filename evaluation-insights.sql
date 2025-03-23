SELECT 
    s.SubmissionID,
    t.TeamName,
    h.Title AS HackathonTitle,
    COUNT(ev.EvaluationID) AS NumEvaluations,
    AVG(ev.Score) AS AvgScore
FROM Submissions s
JOIN Teams t ON s.TeamID = t.TeamID
JOIN Hackathons h ON s.HackathonID = h.HackathonID
LEFT JOIN Evaluations ev ON s.SubmissionID = ev.SubmissionID
GROUP BY s.SubmissionID, t.TeamName, h.Title;
