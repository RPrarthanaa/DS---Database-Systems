-- LEVEL I QUERIES

-- Lists all the Parisan venues able to house more than 10,000 people
SELECT * 
FROM Venue
WHERE capacity > 10000 AND location = 'Paris';


-- Lists all gold medal athletes and when they were won
SELECT athleteID, DATE_FORMAT(dateOfWin, '%d %M, %Y') AS dateOfWin
FROM Medal
WHERE typeOfMedal LIKE '%Gold%';


-- Lists the name and days each unique venue will be operational
SELECT DISTINCT venueName, DATEDIFF(endDate, startDate) AS operationalDays
FROM Host
WHERE startDate IS NOT NULL AND endDate IS NOT NULL;


-- Lists the name, country and age of each athlete
SELECT name,
	 TRUNCATE(DATEDIFF(SYSDATE(), birthDate)/365, 0) AS age,
	countryCode
FROM Athlete;


-- LEVEL II QUERIES

-- Lists down each country with atleast one athlete
SELECT c.name AS country_name, COUNT(a.athleteID) AS num_of_athletes
FROM Country AS c INNER JOIN Athlete AS a
ON c.countryCode = a.countryCode
GROUP BY (c.countryCode);


-- Lists all venues with capacity greater than the average capacity across all venues
SELECT venueName, location, capacity
FROM Venue 
WHERE capacity > (SELECT AVG(capacity)
		  FROM Venue);


-- Lists all medalists, the type of medal won and the name of the country they represent
SELECT a.athleteID AS athlete_id, a.name AS full_name, m.typeOfMedal AS medal, c.name AS country_name
FROM Athlete AS a 
	INNER JOIN Medal AS m ON a.athleteID = m.athleteID 
	INNER JOIN Country AS c ON a.countryCode = c.countryCode
ORDER BY medal ASC, athlete_id ASC;


-- Lists down the venues with the list of sports played in them
SELECT h.venueName AS venue, 
       (SELECT s.name 
        FROM Sport AS s 
        WHERE s.sportsID = h.sportsID) AS sport_name
FROM Host AS h
ORDER BY venue;


