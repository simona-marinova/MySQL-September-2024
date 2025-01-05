# Упражнение 

# Първа задача

SELECT 	
e.employee_id,
e.job_title,
e.address_id,
a.address_text
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
ORDER BY e.address_id
LIMIT 5;

# Втора задача

SELECT e.first_name,
e.last_name,
t.name AS `town`,
a.address_text
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
JOIN towns AS t
ON a.town_id = t.town_id
ORDER BY first_name, last_name
LIMIT 5;

# Трета задача

SELECT e.employee_id,
e.first_name,
e.last_name,
d.name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.name = "Sales"
ORDER BY e.employee_id DESC;

# Четвърта задача

SELECT e.employee_id,
e.first_name,
e.salary,
d.name
FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE e.salary > 15000
ORDER BY е.department_id DESC
LIMIT 5;

# Пета задача

SELECT e.employee_id,
e.first_name 
FROM employees AS e
LEFT JOIN employees_projects AS e_p
ON e.employee_id = e_p.employee_id
WHERE e_p.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

# Шеста задача

SELECT e.first_name,
e.last_name,
e.hire_date,
d.name
FROM employees AS e
JOIN departments AS d ON
e.department_id = d.department_id
WHERE hire_date > "1999-01-01" AND d.name = "Sales" OR d.name = "Finance"
ORDER BY e.hire_date;

# Седма задача

SELECT e.employee_id,
e.first_name,
p.name
FROM employees AS e
JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id
JOIN projects AS p
ON ep.project_id = p.project_id
WHERE DATE(p.start_date) > "2002-08-13" AND p.end_date IS NULL
ORDER BY e.first_name, p.name
LIMIT 5;

# Осма задача

SELECT e.employee_id,
e.first_name,
IF (YEAR(p.start_date)>=2005, NULL, p.name) 
FROM employees AS e
JOIN employees_projects AS e_p
ON e.employee_id = e_p.employee_id
JOIN projects AS p
ON e_p.project_id = p.project_id
WHERE e.employee_id=24
ORDER BY p.name;


# Девета задача

SELECT e.employee_id,
e.first_name,
e.manager_id,
m.first_name
FROM employees AS e
JOIN employees AS m 
ON e.manager_id = m.employee_id
WHERE e.manager_id = 3 OR e.manager_id = 7
ORDER BY e.first_name;


# Десета задача

SELECT e.employee_id,
CONCAT(e.first_name, " ", e.last_name) AS employee_name,
CONCAT(m.first_name, " ", m.last_name) AS manager_name,
d.name
FROM employees AS e
JOIN employees AS m
ON e.manager_id = m.employee_id
JOIN departments AS d
ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;


# 11 ЗАДАЧА

SELECT 
AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;

# 12 задача

SELECT m_c.country_code,	
m.mountain_range,
p.peak_name,
p.elevation
FROM peaks AS p
JOIN mountains_countries AS m_c
 ON p.mountain_id = m_c.mountain_id
 JOIN mountains AS m
 ON p.mountain_id = m.id
 WHERE m_c.country_code = "BG" AND p.elevation > 2835
 ORDER BY p.elevation DESC;
 
 
 # 13 задача
 
 SELECT 
m_c.country_code,
COUNT(m.mountain_range)
FROM mountains AS m
JOIN mountains_countries AS m_c
ON m.id = m_c.mountain_id
GROUP BY m_c.country_code
HAVING m_c.country_code ="BG" OR m_c.country_code = "RU" OR m_c.country_code = "US"
ORDER BY COUNT(m.mountain_range) DESC;

# 14 задача

SELECT
c.country_name,
r.river_name
FROM rivers AS r
RIGHT JOIN countries_rivers AS c_r
ON r.id = c_r.river_id
RIGHT JOIN countries AS c
ON c_r.country_code = c.country_code
WHERE c.continent_code = "AF"
ORDER BY c.country_name
LIMIT 5;

# 16 задача

SELECT
COUNT(c.country_code)
-- mc.mountain_id
FROM
countries AS c
LEFT JOIN mountains_countries AS mc
ON c.country_code = mc.country_code
WHERE mountain_id IS NULL
ORDER BY c.country_code;

# 17 задача

SELECT c.country_name,
MAX(p.elevation),
MAX(r.length)
FROM countries AS c
LEFT JOIN mountains_countries AS mc
ON c.country_code = mc.country_code
LEFT JOIN peaks AS p
ON mc.mountain_id = p.mountain_id
LEFT JOIN countries_rivers AS cr
ON c.country_code = cr.country_code
LEFT JOIN rivers AS r
ON cr.river_id = r.id
GROUP BY country_name
ORDER BY MAX(p.elevation) DESC, MAX(r.length) DESC, c.country_name
LIMIT 5;

 
 

