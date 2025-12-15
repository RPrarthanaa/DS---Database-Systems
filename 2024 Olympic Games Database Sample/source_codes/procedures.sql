DELIMITER //

CREATE PROCEDURE GetSportStatus()
BEGIN
	-- Sets status of sports with no medals awarded as "Ongoing" with the rest being "Finished"
	SELECT
		s.sportsID,
		s.name,
		CASE
			WHEN m.sportsID IS NOT NULL THEN 'Finished'
			ELSE 'Ongoing'
		END AS status
	FROM Sport AS s LEFT JOIN Medal AS m 
	ON s.sportsID = m.sportsID
	GROUP BY s.sportsID;
END
//


CREATE PROCEDURE GetSportsList(
    IN vName VARCHAR(40),
    OUT list VARCHAR(1000)
)
BEGIN
    DECLARE sport VARCHAR(15);
    DECLARE done INTEGER DEFAULT 0;
    DECLARE curSportList CURSOR FOR 
        SELECT s.name  
        FROM Sport AS s RIGHT OUTER JOIN Host AS h ON h.sportsID = s.sportsID 
        WHERE h.venueName = vName;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Initialize the list to an empty string
    SET list = '';
    
    OPEN curSportList;
    
    getSports: LOOP
        FETCH curSportList INTO sport;
        IF done = 1 THEN
            LEAVE getSports;
        END IF;
        
        -- Concatenate sports with comma separation
        IF list = '' THEN
            SET list = sport;
        ELSE
            SET list = CONCAT(list, ', ', sport);
        END IF;
        
    END LOOP getSports;
    
    CLOSE curSportList;

END
//
DELIMITER ;

