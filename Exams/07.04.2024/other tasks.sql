-- 6та

SELECT d_s.id, 
d_s.name, 
c.brand
FROM driving_schools AS d_s
JOIN cars AS c
ON d_s.car_id = c.id
JOIN instructors_driving_schools AS i_d_s
ON d_s.id NOT IN (
SELECT driving_school_id FROM instructors_driving_schools)
GROUP BY d_s.id
ORDER BY c.brand, d_s.id
LIMIT 5;


-- 7ма

SELECT i.first_name, 
i.last_name,
COUNT(i_s.student_id) AS count,
(SELECT c.name FROM cities AS c
JOIN driving_schools AS d_s
ON c.id = d_s.city_id
JOIN instructors_driving_schools AS i_d_s
ON i_d_s.driving_school_id = d_s.id
WHERE i.id = i_d_s.instructor_id
)
FROM  instructors AS i
JOIN instructors_students AS i_s
ON i.id = i_s.instructor_id
GROUP BY i.id
HAVING count>1
ORDER BY count DESC, i.first_name;

-- 8ма задача

SELECT
c.name,
COUNT(*) AS count
FROM cities AS c
JOIN driving_schools AS d_s
ON  d_s.city_id = c.id
JOIN instructors_driving_schools AS i_d_s
ON i_d_s.driving_school_id = d_s.id
GROUP BY c.name
HAVING count>0
ORDER BY count DESC;


-- 9та задача

SELECT 
CONCAT(first_name, " ", last_name) AS full_name,
CASE
WHEN YEAR(has_a_license_from) >= 1980 AND YEAR(has_a_license_from) < 1990 THEN "Specialist"
WHEN YEAR(has_a_license_from) >=1990 AND YEAR(has_a_license_from) <2000 THEN "Advanced"
WHEN YEAR(has_a_license_from)>=2000 AND YEAR(has_a_license_from)<2008 THEN "Experienced"
WHEN YEAR(has_a_license_from)>=2008 AND YEAR(has_a_license_from)<2015 THEN "Qualified"
WHEN YEAR(has_a_license_from)>=2015 AND YEAR(has_a_license_from)<2020 THEN "Provisional"
ELSE "Trainee"
END AS "level"
FROM instructors
ORDER BY YEAR(has_a_license_from), first_name;

-- 10 та задача 

DROP FUNCTION udf_average_lesson_price_by_city;
DELIMITER $$
CREATE FUNCTION udf_average_lesson_price_by_city (name VARCHAR(40)) 
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN
DECLARE price DECIMAL (19,4);
SET price :=(
SELECT AVG(average_lesson_price)
FROM cities AS c
JOIN driving_schools AS d_s
ON c.id = d_s.city_id
GROUP BY c.name
HAVING c.name = name);
RETURN ROUND(price,2);
END$$
DELIMITER ;


-- 11ta zadacha

DELIMITER $$
DROP PROCEDURE udp_find_school_by_car;

CREATE PROCEDURE udp_find_school_by_car(brand VARCHAR(20))
BEGIN
SELECT 
d_s.name,
d_s.average_lesson_price
FROM driving_schools AS d_s
JOIN cars AS c
ON d_s.car_id = c.id
WHERE c.brand = brand
ORDER BY average_lesson_price DESC;
END$$
DELIMITER ;








