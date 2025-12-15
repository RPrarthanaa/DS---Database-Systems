-- Trigger 2
-- Updates numOfAttendees in Country after athlete is added
CREATE TRIGGER update_numOfAttendees_athelete
	AFTER INSERT ON Athlete
	FOR EACH ROW
	
	UPDATE Country
	SET numOfAttendees = numOfAttendees + 1
	WHERE countryCode = NEW.countryCode;


-- Trigger 3
-- Updates numOfAttendees in Country after coach is added
CREATE TRIGGER update_numOfAttendees_coach
	AFTER INSERT ON Coach
	FOR EACH ROW

	UPDATE Country
	SET numOfAttendees = numOfAttendees + 1
	WHERE countryCode = NEW.countryCode;


-- Trigger 1
DELIMITER //

CREATE TRIGGER update_playin_table
	AFTER INSERT ON Athlete
	FOR EACH ROW
BEGIN
	-- Updates PlayIn table with a new row every time an athlete is added
	DECLARE vName VARCHAR(40);
	
	SELECT venueName 
	FROM Host
	WHERE sportsID = NEW.sportsID INTO vName;
	
	IF vName IS NOT NULL THEN
		INSERT INTO PlayIn
		VALUES (NEW.athleteID, vName);
	END IF;
END;
//
DELIMITER ;
