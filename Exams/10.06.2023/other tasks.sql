-- 2

INSERT INTO courses (name, duration_hours, start_date, teacher_name, description, university_id )
SELECT 
CONCAT(teacher_name, " ", "course"),
CHAR_length(name) /10,
DATE_ADD(start_date, INTERVAL 5 DAY),
REVERSE(teacher_name),
CONCAT("Course ", teacher_name, REVERSE(description)),
DAY(start_date)
FROM courses
WHERE id<=5;


-- 3

UPDATE universities
SET tuition_fee = tuition_fee + 300
WHERE id >=5 AND id<=12;

-- 4


DELETE FROM universities
WHERE number_of_staff IS NULL;

-- 5

SELECT * FROM cities
ORDER BY population DESC;


-- 6

SELECT first_name, last_name, age, phone, email
FROM students
WHERE age>=21
ORDER BY first_name DESC, email, id
LIMIT 10;

-- 7

SELECT CONCAT(first_name," ", last_name),
SUBSTRING(email,2,10) username,
REVERSE(phone) AS password
FROM students
WHERE id NOT IN (
SELECT student_id 
FROM students_courses
)
ORDER BY password DESC;

-- 8

SELECT
COUNT(student_id) AS count,
u.name
FROM students_courses AS s_c
JOIN courses  AS c
ON s_c.course_id = c.id
JOIN universities AS u
ON c.university_id = u.id
GROUP BY u.name
HAVING count>=8
ORDER BY count DESC, u.name DESC;

-- 9

SELECT u.name,
c.name AS city_name,
u.address,
CASE
WHEN tuition_fee <800 THEN "cheap"
WHEN tuition_fee>=800 AND tuition_fee<1200 THEN "normal"
WHEN tuition_fee>=1200 AND tuition_fee<2500 THEN "high"
ELSE "expensive"
END AS price_rank,
tuition_fee
FROM universities AS u
JOIN cities AS c
ON u.city_id = c.id
ORDER BY tuition_fee;


-- 10

DELIMITER $$
CREATE FUNCTION udf_average_alumni_grade_by_course_name (course_name VARCHAR(60)) 
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN
DECLARE average_grade DECIMAL(19,2);
SET average_grade :=(
SELECT
AVG(grade)
FROM students_courses AS s_c
JOIN courses AS c
ON s_c.course_id = c.id
JOIN students AS s
ON s_c.student_id = s.id
WHERE c.name = course_name AND s.is_graduated =1
GROUP BY c.name);
RETURN average_grade;
END$$
DELIMITER ;



-- 11


SET SQL_SAFE_UPDATES =0; 


UPDATE students AS s
JOIN students_courses AS s_c
ON s.id = s_c.student_id
JOIN courses AS c
ON s_c.course_id = c.id
SET is_graduated = 1
WHERE YEAR(c.start_date) = "2017";

DELIMITER $$
CREATE PROCEDURE udp_graduate_all_students_by_year (year_started INT)
BEGIN 
UPDATE students AS s
JOIN students_courses AS s_c
ON s.id = s_c.student_id
JOIN courses AS c
ON s_c.course_id = c.id
SET is_graduated = 1
WHERE YEAR(c.start_date) = year_started;
END$$
DELIMITER ;




