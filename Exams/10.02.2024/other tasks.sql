-- 2 

INSERT INTO preserves (name, latitude, longitude, area, type, established_on)
SELECT 
CONCAT(name, " ", "is in South Hemisphere"),
latitude,
longitude,
area*id,
LOWER(type),
established_on
FROM preserves 
WHERE latitude < 0;

-- 3та

UPDATE workers
SET salary = salary +500
WHERE position_id IN (5, 8, 11, 13);

-- 4ta
DELETE FROM preserves
WHERE established_on IS NULL;


-- 5та

SELECT 
CONCAT(first_name, " ", last_name) AS full_name,
TIMESTAMPDIFF (DAY, DATE(start_date), "2024-01-01") AS days_of_expirience
FROM workers
WHERE "2024" - YEAR(start_date) >5
ORDER BY days_of_expirience DESC
LIMIT 10;

-- 6та

SELECT 
w.id,
w.first_name,
w.last_name,
p.name,
c.country_code
FROM workers AS w
JOIN preserves AS p
ON w.preserve_id = p.id
JOIN countries_preserves AS c_p
ON p.id = c_p.preserve_id
JOIN countries AS c
ON c_p.country_id = c.id
WHERE salary>5000 AND age<50
ORDER BY c.country_code;

-- 7ма

SELECT p.name,
COUNT(*) AS count
FROM preserves AS p
JOIN workers AS w
ON p.id = w.preserve_id
WHERE  w.is_armed =1
GROUP BY p.name
ORDER BY count DESC, p.name;

-- 8ма

SELECT 
p.name,
c.country_code,
YEAR(p.established_on)
FROM preserves AS p
JOIN countries_preserves AS c_p
ON p.id = c_p.preserve_id
JOIN countries AS c
ON c_p.country_id = c.id
WHERE established_on IS NOT NULL AND MONTH(p.established_on) = "05"
ORDER BY p.established_on
LIMIT 5;

-- 9та

SELECT 
id, 
name,
CASE
WHEN area<=100 THEN "very small"
WHEN area<=1000 THEN "small"
WHEN area<=10000 THEN "medium"
WHEN area<= 50000 THEN "large"
ELSE "very large"
END AS category
FROM preserves
ORDER BY area DESC;

-- 10та 


DROP FUNCTION udf_average_salary_by_position_name;
DELIMITER $$
CREATE FUNCTION udf_average_salary_by_position_name (name VARCHAR(40)) 
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN 
DECLARE average_salary DECIMAL(19,2);
SET average_salary  := (
SELECT 
ROUND(AVG(salary),2)
FROM workers AS w
JOIN positions AS p
ON w.position_id = p.id
WHERE p.name = name
GROUP BY w.position_id);
RETURN average_salary;
END$$
DELIMITER ;

-- 11та

DELIMITER $$
CREATE PROCEDURE udp_increase_salaries_by_country (country_name VARCHAR(40))
BEGIN 
UPDATE workers AS w
JOIN preserves AS p
On w.preserve_id = p.id
JOIN countries_preserves AS c_p
ON w.preserve_id = c_p.preserve_id
JOIN countries AS c
ON c_p.country_id = c.id
SET salary = salary + salary*0.05
WHERE c.name = country_name;
END$$