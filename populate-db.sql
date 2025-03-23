USE HackathonManager;

-- Populate USERS table with 12 users (mix of Admins and Participants)
INSERT INTO Users (FirstName, LastName, Email, Role)
VALUES 
  ('Alice', 'Smith', 'alice.smith@example.com', 'Admin'),
  ('Bob', 'Jones', 'bob.jones@example.com', 'Participant'),
  ('Charlie', 'Brown', 'charlie.brown@example.com', 'Participant'),
  ('Diana', 'Prince', 'diana.prince@example.com', 'Participant'),
  ('Evan', 'Lee', 'evan.lee@example.com', 'Participant'),
  ('Fiona', 'White', 'fiona.white@example.com', 'Admin'),
  ('George', 'Martin', 'george.martin@example.com', 'Participant'),
  ('Hannah', 'Adams', 'hannah.adams@example.com', 'Participant'),
  ('Ian', 'Wright', 'ian.wright@example.com', 'Participant'),
  ('Julia', 'Roberts', 'julia.roberts@example.com', 'Participant'),
  ('Kevin', 'Bacon', 'kevin.bacon@example.com', 'Admin'),
  ('Laura', 'Palmer', 'laura.palmer@example.com', 'Participant');

-- Populate USER_PHONE_NUMBERS with multiple phone numbers for users
INSERT INTO UserPhoneNumbers (UserID, PhoneNumber)
VALUES 
  (1, '555-1001'), (1, '555-1002'),
  (2, '555-2001'),
  (3, '555-3001'), (3, '555-3002'),
  (4, '555-4001'),
  (5, '555-5001'), (5, '555-5002'),
  (6, '555-6001'),
  (7, '555-7001'), (7, '555-7002'),
  (8, '555-8001'),
  (9, '555-9001'),
  (10, '555-1010'), (10, '555-1011'),
  (11, '555-1111'),
  (12, '555-1212');

-- Populate HACKATHONS table with 4 hackathons created by Admins (UserID 1,6,11)
INSERT INTO Hackathons (Title, Description, StartDate, EndDate, CreatedBy)
VALUES 
  ('Campus Hackathon', 'Annual campus hackathon event for students.', '2025-05-01 09:00:00', '2025-05-01 17:00:00', 1),
  ('Innovation Challenge', 'A challenge to promote innovative ideas and prototypes.', '2025-06-15 10:00:00', '2025-06-15 18:00:00', 6),
  ('Tech Fest', 'An event to celebrate technology and entrepreneurship.', '2025-07-10 08:00:00', '2025-07-10 20:00:00', 11),
  ('Global Hack', 'International hackathon focusing on global issues.', '2025-08-05 09:00:00', '2025-08-05 19:00:00', 1);

-- Populate HACKATHON_LOCATIONS table with details for each hackathon (assume hackathons 1-4)
INSERT INTO HackathonLocations (HackathonID, Street, Building, Room, State, ZipCode, Country)
VALUES 
  (1, 'Main St', 'Building A', 'Room 101', 'SC', 12345, 'USA'),
  (2, 'Second Ave', 'Innovation Center', 'Auditorium', 'SC', 23456, 'USA'),
  (3, 'Tech Blvd', 'Entrepreneur Hall', 'Conference Room', 'SC', 34567, 'USA'),
  (4, 'Global Rd', NULL, NULL, 'SC', 45678, 'USA'),
  -- Additional location for Hackathon 4 (for testing multiple locations scenario)
  (4, 'Stanley Ave', 'Center Wing', 'Lab 1', 'SC', 29649, 'USA');

-- Populate TEAMS table with multiple teams per hackathon
INSERT INTO Teams (HackathonID, TeamName, LeaderID)
VALUES 
  ('Team Innovators', 2),   -- Hackathon 1, leader Bob (UserID 2)
  ('Team Creators', 3),      -- Hackathon 1, leader Charlie (UserID 3)
  ('Team Mavericks', 4),     -- Hackathon 1, leader Diana (UserID 4)
  ('Team Pioneers', 5),      -- Hackathon 2, leader Evan (UserID 5)
  ('Team Visionaries', 7),   -- Hackathon 2, leader George (UserID 7)
  ('Team Techies', 8),       -- Hackathon 3, leader Hannah (UserID 8)
  ('Team Entrepreneurs', 9), -- Hackathon 3, leader Ian (UserID 9)
  ('Team Global', 10),       -- Hackathon 4, leader Julia (UserID 10)
  ('Team Innovate', 12);     -- Hackathon 4, leader Laura (UserID 12)

-- Populate TEAM_MEMBERS table with multiple members for each team
INSERT INTO TeamMembers (TeamID, UserID)
VALUES 
  -- For Team Innovators (TeamID 1)
  (1, 2), (1, 3), (1, 4), (1, 5),
  -- For Team Creators (TeamID 2)
  (2, 3), (2, 7), (2, 8),
  -- For Team Mavericks (TeamID 3)
  (3, 4), (3, 9), (3, 10),
  -- For Team Pioneers (TeamID 4)
  (4, 5), (4, 6), (4, 7),
  -- For Team Visionaries (TeamID 5)
  (5, 7), (5, 8), (5, 11),
  -- For Team Techies (TeamID 6)
  (6, 8), (6, 9), (6, 12),
  -- For Team Entrepreneurs (TeamID 7)
  (7, 9), (7, 10), (7, 12),
  -- For Team Global (TeamID 8)
  (8, 10), (8, 11), (8, 12),
  -- For Team Innovate (TeamID 9)
  (9, 12), (9, 2), (9, 4);

-- Populate ENROLLMENTS table linking teams with hackathons (each team enrolls in its corresponding hackathon)
INSERT INTO Enrollments (HackathonID, TeamID, EnrollmentDate)
VALUES 
  (1, 1, NOW()),
  (1, 2, NOW()),
  (1, 3, NOW()),
  (2, 4, NOW()),
  (2, 5, NOW()),
  (3, 6, NOW()),
  (3, 7, NOW()),
  (4, 8, NOW()),
  (4, 9, NOW());

-- Populate SUBMISSIONS table; each team submits one project per hackathon
INSERT INTO Submissions (HackathonID, TeamID, GitHubLink, SubmissionDate)
VALUES 
  (1, 1, 'https://github.com/teaminnovators/campus-hackathon', DEFAULT),
  (1, 2, 'https://github.com/teamcreators/campus-hackathon', DEFAULT),
  (1, 3, 'https://github.com/teammavericks/campus-hackathon', DEFAULT),
  (2, 4, 'https://github.com/teampioneers/innovation-challenge', DEFAULT),
  (2, 5, 'https://github.com/teamvisionaries/innovation-challenge', DEFAULT),
  (3, 6, 'https://github.com/teamtechies/techfest', DEFAULT),
  (3, 7, 'https://github.com/teamentrepreneurs/techfest', DEFAULT),
  (4, 8, 'https://github.com/teamglobal/globalhack', DEFAULT),
  (4, 9, 'https://github.com/teaminnovate/globalhack', DEFAULT);

-- Populate EVALUATIONS table with multiple evaluations per submission
INSERT INTO Evaluations (SubmissionID, EvaluatorID, Score, Comments, EvaluationDate)
VALUES 
  -- For Submission 1
  (1, 1, 92, 'Excellent design and implementation.', DEFAULT),
  (1, 6, 88, 'Strong submission with creative ideas.', DEFAULT),
  (1, 11, 90, 'Well executed and polished.', DEFAULT),
  -- For Submission 2
  (2, 1, 85, 'Good work, but could use more innovation.', DEFAULT),
  (2, 6, 80, 'Satisfactory solution, needs improvement in UX.', DEFAULT),
  -- For Submission 3
  (3, 1, 78, 'Average performance, several bugs noted.', DEFAULT),
  (3, 6, 82, 'Decent work but lacks originality.', DEFAULT),
  -- For Submission 4
  (4, 1, 95, 'Outstanding prototype and concept.', DEFAULT),
  (4, 6, 93, 'Very innovative and well-presented.', DEFAULT),
  (4, 11, 94, 'High quality and impactful solution.', DEFAULT),
  -- For Submission 5
  (5, 1, 87, 'Good execution with minor issues.', DEFAULT),
  (5, 11, 89, 'Solid project with room for refinement.', DEFAULT),
  -- For Submission 6
  (6, 1, 91, 'Impressive use of technology.', DEFAULT),
  (6, 6, 90, 'Very creative and functional design.', DEFAULT),
  -- For Submission 7
  (7, 1, 83, 'Average work, needs more testing.', DEFAULT),
  (7, 11, 85, 'Decent solution but could be more robust.', DEFAULT),
  -- For Submission 8
  (8, 1, 88, 'Good performance overall.', DEFAULT),
  (8, 6, 87, 'Solid project with few improvements needed.', DEFAULT),
  -- For Submission 9
  (9, 1, 80, 'Below average; not competitive enough.', DEFAULT),
  (9, 6, 82, 'Mediocre submission with scope for enhancement.', DEFAULT);

-- Populate WINNERS table with winning records (assume top two winners per hackathon for this example)
INSERT INTO Winners (HackathonID, TeamID, SubmissionID, Position)
VALUES 
  -- For Hackathon 1 (two winners)
  (1, 1, 1, 1),
  (1, 2, 2, 2),
  -- For Hackathon 2
  (2, 4, 4, 1),
  (2, 5, 5, 2),
  -- For Hackathon 3
  (3, 6, 6, 1),
  (3, 7, 7, 2),
  -- For Hackathon 4
  (4, 8, 8, 1),
  (4, 9, 9, 2);
