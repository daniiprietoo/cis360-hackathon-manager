SELECT 
    h.HackathonID,
    h.Title,
    h.StartDate,
    h.EndDate,
    (SELECT COUNT(*) 
     FROM Enrollments e 
     WHERE e.HackathonID = h.HackathonID) AS TotalEnrollments,
    (SELECT COUNT(*) 
     FROM Submissions s 
     WHERE s.HackathonID = h.HackathonID) AS TotalSubmissions,
    (SELECT AVG(ev.Score) 
     FROM Evaluations ev
     JOIN Submissions s ON ev.SubmissionID = s.SubmissionID
     WHERE s.HackathonID = h.HackathonID) AS AvgEvaluationScore
FROM Hackathons h;
