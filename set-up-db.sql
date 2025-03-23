-- Drop the database if it exists and create a new one
DROP DATABASE IF EXISTS HackathonManager;
CREATE DATABASE HackathonManager;
USE HackathonManager;

-- 1. Create the USERS table (strong entity)
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Role ENUM('Participant', 'Admin') NOT NULL
) ENGINE=InnoDB;

-- 2. Create the USER_PHONE_NUMBERS table (weak entity, id-dependent on Users)
CREATE TABLE UserPhoneNumbers (
    UserID INT NOT NULL,
    PhoneNumber VARCHAR(50) NOT NULL,
    PRIMARY KEY (UserID, PhoneNumber),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 3. Create the HACKATHONS table (strong entity)
CREATE TABLE Hackathons (
    HackathonID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Description VARCHAR(1028),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    CreatedBy INT NOT NULL,
    FOREIGN KEY (CreatedBy) REFERENCES Users(UserID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4. Create the HACKATHON_LOCATIONS table (weak entity, id-dependent on Hackathons)
CREATE TABLE HackathonLocations (
    HackathonID INT NOT NULL,
    Street VARCHAR(255) NOT NULL,
    Building VARCHAR(255),
    Room VARCHAR(255),
    State VARCHAR(255) NOT NULL,
    ZipCode INT,
    Country VARCHAR(255) NOT NULL,
    PRIMARY KEY (HackathonID, Street, ZipCode),
    FOREIGN KEY (HackathonID) REFERENCES Hackathons(HackathonID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. Create the TEAMS table (strong entity)
CREATE TABLE Teams (
    TeamID INT AUTO_INCREMENT PRIMARY KEY,
    HackathonID INT NOT NULL,
    TeamName VARCHAR(255) NOT NULL,
    LeaderID INT NOT NULL,
    FOREIGN KEY (HackathonID) REFERENCES Hackathons(HackathonID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (LeaderID) REFERENCES Users(UserID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 6. Create the TEAM_MEMBERS table (associative, id-dependent on Teams and Users)
CREATE TABLE TeamMembers (
    TeamID INT NOT NULL,
    UserID INT NOT NULL,
    PRIMARY KEY (TeamID, UserID),
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 7. Create the ENROLLMENTS table (associative, id-dependent on Hackathons and Teams)
CREATE TABLE Enrollments (
    HackathonID INT NOT NULL,
    TeamID INT NOT NULL,
    EnrollmentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (HackathonID, TeamID),
    FOREIGN KEY (HackathonID) REFERENCES Hackathons(HackathonID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 8. Create the SUBMISSIONS table (strong entity with constraints)
CREATE TABLE Submissions (
    SubmissionID INT AUTO_INCREMENT PRIMARY KEY,
    HackathonID INT NOT NULL,
    TeamID INT NOT NULL,
    GitHubLink VARCHAR(255) NOT NULL UNIQUE,
    SubmissionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (HackathonID, TeamID),  -- Ensures one submission per team per hackathon
    FOREIGN KEY (HackathonID) REFERENCES Hackathons(HackathonID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 9. Create the EVALUATIONS table (strong entity)
CREATE TABLE Evaluations (
    EvaluationID INT AUTO_INCREMENT PRIMARY KEY,
    SubmissionID INT NOT NULL,
    EvaluatorID INT NOT NULL,
    Score FLOAT NOT NULL CHECK (Score BETWEEN 0 AND 100),
    Comments VARCHAR(1028),
    EvaluationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SubmissionID) REFERENCES Submissions(SubmissionID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (EvaluatorID) REFERENCES Users(UserID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 10. Create the WINNERS table (associative, id-dependent on Hackathons, Teams, and Submissions)
CREATE TABLE Winners (
    HackathonID INT NOT NULL,
    TeamID INT NOT NULL,
    SubmissionID INT NOT NULL,
    Position INT NOT NULL CHECK (Position BETWEEN 1 AND 3),
    PRIMARY KEY (HackathonID, TeamID, Position),
    FOREIGN KEY (HackathonID) REFERENCES Hackathons(HackathonID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (SubmissionID) REFERENCES Submissions(SubmissionID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;
