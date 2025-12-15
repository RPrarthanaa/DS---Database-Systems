import mysql.connector

conn = mysql.connector.connect(host='localhost',database='Olympics24_21323157',user='admin',password='admin')
cursor = conn.cursor()

queries = [
    "SELECT * FROM Venue WHERE capacity > 10000 AND location = 'Paris';",
    "SELECT athleteID, DATE_FORMAT(dateOfWin, '%d %M, %Y') AS dateOfWin FROM Medal WHERE typeOfMedal LIKE '%Gold%';",
    "SELECT DISTINCT venueName, DATEDIFF(endDate, startDate) AS operationalDays FROM Host WHERE startDate IS NOT NULL AND endDate IS NOT NULL;",
    "SELECT name, TRUNCATE(DATEDIFF(SYSDATE(), birthDate)/365, 0) AS age, countryCode FROM Athlete;",
    "SELECT c.name AS country_name, COUNT(a.athleteID) AS num_of_athletes FROM Country AS c INNER JOIN Athlete AS a ON c.countryCode = a.countryCode GROUP BY c.countryCode;",
    "SELECT venueName, location, capacity FROM Venue WHERE capacity > (SELECT AVG(capacity) FROM Venue);",
    "SELECT a.athleteID AS athlete_id, a.name AS full_name, m.typeOfMedal AS medal, c.name AS country_name FROM Athlete AS a INNER JOIN Medal AS m ON a.athleteID = m.athleteID INNER JOIN Country AS c ON a.countryCode = c.countryCode ORDER BY medal ASC, athlete_id ASC;",
    "SELECT h.venueName AS venue, (SELECT s.name FROM Sport AS s WHERE s.sportsID = h.sportsID) AS sport_name FROM Host AS h ORDER BY venue;" 
]

for index, query in enumerate(queries, start=1):
    cursor.execute(query)
    
    results = cursor.fetchall()
    
    print(f"\nQUERY {index}")
    for row in results:
        print(row)
        
cursor.close()
conn.close()
