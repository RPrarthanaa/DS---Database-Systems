DROP DATABASE IF EXISTS Olympics24_21323157;
CREATE DATABASE Olympics24_21323157;

USE Olympics24_21323157;

-- Create Country Table
CREATE TABLE Country (
    countryCode CHAR(3) PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    numOfAttendees INT DEFAULT 0
);

-- Create Sport Table
CREATE TABLE Sport (
    sportsID VARCHAR(5) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100),
    sportClassification VARCHAR(15),
    sportCategory VARCHAR(50) NOT NULL
);

-- Create Venue Table
CREATE TABLE Venue (
    venueName VARCHAR(40) PRIMARY KEY,
    location VARCHAR(25) NOT NULL,
    capacity INT
);

-- Create Athlete Table
CREATE TABLE Athlete (
    athleteID CHAR(7) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender CHAR(1),
    role VARCHAR(25),
    birthDate DATE,
    countryCode CHAR(3),
    sportsID VARCHAR(5),
    CONSTRAINT fk_country_athlete
    	FOREIGN KEY (countryCode) REFERENCES Country(countryCode)
    	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_sports_athlete
    	FOREIGN KEY (sportsID) REFERENCES Sport(sportsID)
    	ON UPDATE CASCADE ON DELETE SET NULL
);

-- Create Medalist Table
CREATE TABLE Medalist (
    athleteID CHAR(7) PRIMARY KEY,
    CONSTRAINT fk_athlete_medalist
    	FOREIGN KEY (athleteID) REFERENCES Athlete(athleteID)
    	ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Coach Table
CREATE TABLE Coach (
    coachID CHAR(7) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    role VARCHAR(30),
    countryCode CHAR(3),
    sportsID VARCHAR(5),
    CONSTRAINT fk_country_coach
    	FOREIGN KEY (countryCode) REFERENCES Country(countryCode)
    	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_sports_coach
    	FOREIGN KEY (sportsID) REFERENCES Sport(sportsID)
    	ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Medal Table
CREATE TABLE Medal (
    medalCode INT AUTO_INCREMENT PRIMARY KEY,
    typeOfMedal VARCHAR(10) CHECK (typeOfMedal IN ('Gold', 'Silver', 'Bronze')) NOT NULL,
    dateOfWin DATE,
    athleteID CHAR(7),
    sportsID VARCHAR(5),
    CONSTRAINT fk_athlete_medal
    	FOREIGN KEY (athleteID) REFERENCES Medalist(athleteID)
    	ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_sports_medal
    	FOREIGN KEY (sportsID) REFERENCES Sport(sportsID)
    	ON UPDATE CASCADE ON DELETE SET NULL
);

-- Create PlayIn Table
CREATE TABLE PlayIn (
    athleteID CHAR(7),
    venueName VARCHAR(40),
    PRIMARY KEY (athleteID, venueName),
    CONSTRAINT fk_athlete_playin
    	FOREIGN KEY (athleteID) REFERENCES Athlete(athleteID)
    	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_venue_playin
    	FOREIGN KEY (venueName) REFERENCES Venue(venueName)
    	ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create Host Table
CREATE TABLE Host (
    sportsID VARCHAR(5),
    venueName VARCHAR(40),
    startDate DATE,
    endDate DATE,
    PRIMARY KEY (sportsID, venueName),
    CONSTRAINT fk_sports_host
    	FOREIGN KEY (sportsID) REFERENCES Sport(sportsID)
    	ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_venue_host
    	FOREIGN KEY (venueName) REFERENCES Venue(venueName)
    	ON UPDATE CASCADE ON DELETE CASCADE
);

