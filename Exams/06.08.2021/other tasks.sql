-- 2

INSERT INTO games (name, rating, budget, team_id)
SELECT 
LOWER(REVERSE(SUBSTRING(name,2))),
id,
leader_id*1000,
id
FROM teams
WHERE id BETWEEN 1 AND 9;

-- 3

UPDATE employees
SET salary = salary +1000
WHERE id IN (
SELECT leader_id 
FROM teams) AND age<40 AND salary<5000;


-- 4

DELETE g FROM games AS g
LEFT JOIN games_categories AS g_c
ON g.id = g_c.game_id
WHERE g.release_date IS NULL AND g_c.category_id IS NULL;

-- 5

SELECT 
first_name,
last_name,
age, salary, happiness_level
FROM employees
ORDER BY salary, id;


-- 6

SELECT 
t.name,
a.name,
CHAR_LENGTH(a.name)
FROM teams AS t
JOIN offices AS o
ON t.office_id = o.id
JOIN addresses AS a
ON o.address_id = a.id
WHERE o.website IS NOT NULL
ORDER BY t.name, a.name;


-- 7

SELECT
c.name,
COUNT(game_id) AS count,
ROUND(AVG(g.budget),2),
MAX(g.rating)
 FROM categories AS c
JOIN games_categories AS g_c
ON c.id = g_c.category_id
JOIN games AS g
ON g_c.game_id = g.id
GROUP BY c.name
HAVING MAX(g.rating)>=9.5
ORDER BY count DESC, c.name;

-- 8

SELECT 
g.name,
g.release_date,
CONCAT(SUBSTRING(g.description,1,10), "...") AS summary,
CASE
WHEN MONTH(g.release_date) IN (01,02,03) THEN "Q1"
WHEN MONTH(g.release_date) IN (04,05,06) THEN "Q2"
WHEN MONTH(g.release_date) IN (07,08,09) THEN "Q3"
WHEN MONTH(g.release_date) IN (10,11,12) THEN "Q4"
END AS quarter,
t.name
FROM games AS g
JOIN teams AS t
ON t.id = g.team_id
WHERE YEAR(g.release_date) = "2022"
AND MONTH(g.release_date) %2 =0 AND g.name LIKE "% 2"
ORDER BY quarter;


-- 9

SELECT 
g.name,
IF(g.budget <50000, "Normal budget", "Insufficient budget") AS budget_level,
t.name, 
a.name
FROM games AS g
LEFT JOIN games_categories AS g_c
ON g.id = g_c.game_id
LEFT JOIN teams AS t
ON g.team_id = t.id
LEFT JOIN offices AS o
ON t.office_id = o.id
LEFT JOIN addresses AS a
ON o.address_id = a.id
WHERE release_date IS NULL 
AND g_c.category_id IS NULL
ORDER BY g.name;


-- 10

SELECT g.name,
t.name, 
a.name
FROM games AS g
JOIN teams AS t
JOIN offices AS o
ON t.office_id = o.id
JOIN addresses AS a
ON o.address_id = a.id
ON g.team_id = t.id
WHERE g.name = "Bitwolf";

DELIMITER $$
CREATE FUNCTION udf_game_info_by_name (game_name VARCHAR (20)) 
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
DECLARE info VARCHAR(200);
SET info = CONCAT("The ", 
(SELECT g.name
FROM games AS g
JOIN teams AS t
JOIN offices AS o
ON t.office_id = o.id
JOIN addresses AS a
ON o.address_id = a.id
ON g.team_id = t.id
WHERE g.name = game_name), 
" is developed by a ",
(SELECT
t.name
FROM games AS g
JOIN teams AS t
JOIN offices AS o
ON t.office_id = o.id
JOIN addresses AS a
ON o.address_id = a.id
ON g.team_id = t.id
WHERE g.name = game_name),
 " in an office with an address ",
(SELECT
a.name
FROM games AS g
JOIN teams AS t
JOIN offices AS o
ON t.office_id = o.id
JOIN addresses AS a
ON o.address_id = a.id
ON g.team_id = t.id
WHERE g.name = game_name));
RETURN info;
END$$
DELIMITER ;

-- 11

DELIMITER $$
CREATE PROCEDURE udp_update_budget (min_game_rating FLOAT) 
BEGIN 
UPDATE games AS g
SET g.budget = g.budget + 100000
WHERE g.id NOT IN (SELECT game_id FROM games_categories)
AND g.rating >min_game_rating AND release_date IS NOT NULL;
UPDATE games AS g
SET release_date = DATE_ADD(release_date, INTERVAL 1 YEAR)
WHERE g.id NOT IN (SELECT game_id FROM games_categories)
AND g.rating >min_game_rating AND release_date IS NOT NULL;
END$$
DELIMITER ;

