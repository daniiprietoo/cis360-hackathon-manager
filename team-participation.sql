SELECT 
    t.TeamID,
    t.TeamName,
    CONCAT(u_leader.FirstName, ' ', u_leader.LastName) AS TeamLeader,
    GROUP_CONCAT(CONCAT(u.MemberFirstName, ' ', u.MemberLastName) SEPARATOR ', ') AS TeamMembers
FROM Teams t
JOIN Users u_leader ON t.LeaderID = u_leader.UserID
JOIN TeamMembers tm ON t.TeamID = tm.TeamID
JOIN (
    SELECT UserID, FirstName AS MemberFirstName, LastName AS MemberLastName
    FROM Users
) u ON tm.UserID = u.UserID
WHERE t.HackathonID = 1
GROUP BY t.TeamID, t.TeamName, u_leader.FirstName, u_leader.LastName;
