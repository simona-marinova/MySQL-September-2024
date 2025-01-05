# 1 задача

SELECT e.employee_id,
CONCAT_WS( " ", e.first_name, middle_name, e.last_name) AS `full_name`,
e.department_id,
d.name
FROM employees AS e
#WHERE e.employee_id = d.manager_id
JOIN departments AS d
ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;


SELECT e.employee_id,
CONCAT_WS( " ", e.first_name, e.middle_name, e.last_name) AS `full_name`,
m.department_id
FROM employees AS e
JOIN employees AS m
ON e.manager_id = m.employee_id
ORDER BY m.employee_id;

SELECT e.employee_id,
CONCAT( e.first_name," ", e.last_name) AS `full_name`,
d.department_id,
d.name
FROM employees AS e
JOIN departments AS d
ON e.employee_id = d.manager_id
ORDER BY e.employee_id
LIMIT 5;


SELECT * FROM employees
WHERE manager_id = 2; 

SELECT employee_id FROM employees
WHERE first_name LIKE "z%";

SELECT * FROM employees
WHERE manager_id = (SELECT employee_id FROM employees
WHERE first_name LIKE "z%"
LIMIT 1);

SELECT 
ROUND(
(SELECT COUNT(*) FROM employees) / 
(SELECT COUNT(*) FROM departments) ,
2 );

SELECT COUNT(*) 
FROM employees
WHERE salary > (
SELECT
AVG(salary) FROM employees
);

SELECT t.town_id, t.name,
a.address_text
FROM (SELECT * FROM towns
WHERE name IN ("San Francisco", "Sofia","Carnation")) AS t
JOIN addresses AS a
ON t.town_id = a.town_id
ORDER BY t.town_id, a.address_id;

SELECT * FROM towns
WHERE name IN ("San Francisco", "Sofia","Carnation");


SELECT t.town_id, t.name,
a.address_text
FROM towns AS t
JOIN addresses AS a
ON t.town_id = a.town_id
WHERE name IN ("San Francisco", "Sofia","Carnation")
ORDER BY t.town_id, a.address_id;

SELECT t.town_id, t.name,
a.address_text
FROM towns AS t
JOIN addresses AS a
ON t.town_id = a.town_id AND name IN ("San Francisco", "Sofia","Carnation") 
ORDER BY t.town_id, a.address_id;

SELECT employee_id, 
first_name,
 last_name,
 department_id, 
 salary 
 FROM employees
 WHERE manager_id IS NULL;