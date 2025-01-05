-- 2

INSERT INTO airplanes (model, passengers_capacity, tank_capacity, cost)
SELECT 
CONCAT(REVERSE(first_name), "797"),
CHAR_LENGTH(last_name)*17,
id*790,
CHAR_LENGTH(first_name)*50.6
FROM passengers 
WHERE id<=5;

-- 3

UPDATE flights AS f
JOIN countries AS c
ON f.departure_country = c.id
SET airplane_id = airplane_id + 1
WHERE c.name = "Armenia";

-- 4

DELETE FROM flights AS f
WHERE id NOT IN (SELECT flight_id FROM flights_passengers);


-- 5

SELECT * FROM airplanes
ORDER BY cost DESC, id DESC;

-- 6

SELECT 
flight_code, departure_country,
airplane_id, departure 
FROM flights
WHERE YEAR(departure) = "2022"
ORDER BY airplane_id, flight_code
LIMIT 20;

-- 7

SELECT 
CONCAT(UPPER(SUBSTRING(last_name, 1,2)), p.country_id),
CONCAT(p.first_name, " ", p.last_name) AS full_name,
p.country_id
FROM flights AS f
RIGHT JOIN flights_passengers AS f_p
ON f.id = f_p.flight_id
RIGHT JOIN passengers AS p
ON f_p.passenger_id = p.id
WHERE p.id NOT IN (
SELECT passenger_id 
FROM flights_passengers
)
ORDER BY p.country_id;


-- 8 грешна е

SELECT c.name,
c.currency,
COUNT(passenger_id) AS count
FROM flights_passengers AS f_p
JOIN flights AS f
ON f_p.flight_id =f.id
JOIN countries AS c
ON f.destination_country = c.id
GROUP BY c.name
HAVING count>=20
ORDER BY count DESC;


-- 9

SELECT flight_code,
departure,
CASE
WHEN TIME(departure)>="05:00:00" AND TIME(departure)<="11:59:00" THEN "Morning"
WHEN TIME(departure)>="12:00:00" AND TIME(departure)<="16:59:00" THEN "Afternoon"
WHEN TIME(departure)>="17:00:00" AND TIME(departure)<="20:59:00" THEN "Evening"
ELSE "Night"
END AS "day_part"
FROM flights
ORDER BY flight_code DESC;

-- 10


DROP FUNCTION udf_count_flights_from_country;
DELIMITER $$
CREATE FUNCTION udf_count_flights_from_country(country VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE count_of_flights INT;
SET count_of_flights :=(SELECT
COUNT(*) AS count
FROM countries AS c
JOIN flights AS f
ON c.id = f.departure_country
WHERE c.name = country
GROUP BY f.departure_country);
RETURN count_of_flights;
END$$
DELIMITER ;

-- 11


DROP PROCEDURE udp_delay_flight;

DELIMITER $$
CREATE PROCEDURE udp_delay_flight (code VARCHAR(50))
BEGIN 
UPDATE flights
SET has_delay = 1
WHERE flight_code = code;
UPDATE flights 
SET departure = DATE_ADD(departure, INTERVAL 30 MINUTE) 
WHERE flight_code = code;
END$$
DELIMITER ;
