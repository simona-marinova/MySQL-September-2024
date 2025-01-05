# Втора изпитна задача

INSERT INTO actors (first_name, last_name, birthdate, height, awards, country_id ) 
SELECT (REVERSE(first_name)),
(REVERSE(last_name)),
(DATE(birthdate -2)),
(height +10),
(country_id),
(3) FROM actors
WHERE id <=10;

# Трета изпитна задача

UPDATE movies_additional_info 
SET runtime = runtime - 10
WHERE id>=15 AND id<=25;

# 4 та задача
SET SQL_SAFE_UPDATES =0;

DELETE c FROM countries AS c
LEFT JOIN movies AS m
ON m.country_id = c.id
WHERE title IS NULL;
 
 -- втори  начин:
DELETE FROM countries
WHERE id NOT IN (SELECT country_id FROM movies);


# ако сме изпълнили заявките от 2рата секция от изпитната задача сега трябва да DROP DATABASE и да изпълним наново всички заявки от 1ва задача + наново да си
# insert-нем данните от ресурсите в базата

# 5та задача

SELECT * FROM countries
ORDER BY currency DESC, id;


# 6та задача

SELECT
  m.id, 
  m.title,
  m_a_i.runtime,
  m_a_i.budget, 
  m_a_i.release_date
FROM movies_additional_info AS m_a_i
JOIN movies AS m
ON m.id = m_a_i.id
WHERE YEAR(m_a_i.release_date) BETWEEN 1996 AND 1999
ORDER BY runtime, id
LIMIT 20;


# 7ма задача

SELECT CONCAT(first_name, " ", last_name) AS full_name,
CONCAT( REVERSE(last_name), LENGTH(last_name), "@cast.com") AS email,
(2022 - YEAR(birthdate)) AS age, 
height 
FROM actors AS a
LEFT JOIN movies_actors AS m_a
ON a.id = m_a.actor_id
WHERE m_a.movie_id IS NULL
ORDER BY height;

-- втори вариант:

SELECT CONCAT(first_name, " ", last_name) AS full_name,
CONCAT( REVERSE(last_name), LENGTH(last_name), "@cast.com") AS email,
(2022 - YEAR(birthdate)) AS age, 
height 
FROM actors
WHERE id NOT IN (SELECT actor_id FROM movies_actors)
ORDER BY height;

-- 8ма задача

SELECT c.name,
COUNT(m.title) AS movies_count
FROM countries AS c
JOIN movies AS m
ON c.id = m.country_id
GROUP BY c.name
HAVING movies_count >=7
ORDER BY c.name DESC;

# 9та задача

SELECT m.title,
(CASE
WHEN m_a_i.rating <=4 THEN "poor"
WHEN m_a_i.rating <=7 THEN "good"
ELSE "excellent"
END) AS rating,
IF (m_a_i.has_subtitles = 1, "english", "-") AS subtitles, 
m_a_i.budget
FROM movies AS m
JOIN movies_additional_info AS m_a_i
ON m.id = m_a_i.id
ORDER BY m_a_i.budget DESC;

# 10та задача

DELIMITER $$

CREATE FUNCTION udf_actor_history_movies_count(full_name VARCHAR(50)) 
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE history_movies_count INT;
SET history_movies_count := (SELECT 
COUNT(g.name) 
FROM actors AS a 
JOIN movies_actors AS m_a
ON a.id = m_a.actor_id
JOIN genres_movies AS g_m
ON m_a.movie_id = g_m.movie_id
JOIN genres AS g
ON g_m.genre_id = g.id
WHERE g.name = "History" AND CONCAT(a.first_name, " ", a.last_name) = full_name
GROUP BY g.name
);
RETURN history_movies_count;
END$$
DELIMITER ;


SELECT udf_actor_history_movies_count('Stephan Lundberg')  AS 'history_movies';


# 11та задача


DELIMITER $$
CREATE PROCEDURE udp_award_movie (movie_title VARCHAR(50))
BEGIN 
UPDATE actors AS a
JOIN movies_actors AS m_a
ON m_a.actor_id = a.id
JOIN movies AS m
ON m_a.movie_id = m.movie_info_id
SET a.awards = a.awards +1
WHERE m.title = movie_title;
END$$
DELIMITER ;

CALL udp_award_movie('Tea For Two');
 
 
