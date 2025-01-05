# 01. Find Names of All Employees by First Name

SELECT first_name, last_name 
FROM employees
WHERE first_name LIKE "Sa%"
ORDER BY employee_id;

# 02. Find Names of All Employees by Last Name

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE "%ei%";

# 03. Find First Names of All Employess	

SELECT first_name 
FROM employees
WHERE department_id IN (3,10) AND
YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;

# 04. Find All Employees Except Engineers	

SELECT first_name, last_name 
FROM employees
WHERE job_title NOT LIKE "%engineer%"
ORDER BY employee_id;

# 05. Find Towns with Name Length

SELECT name FROM towns
WHERE CHAR_LENGTH(name) =5 OR CHAR_LENGTH(name) =6
ORDER BY name;

# 06. Find Towns Starting With

SELECT * FROM towns
WHERE name LIKE "M%" OR name LIKE "K%" OR NAME LIKE "B%" OR NAME LIKE "E%"
ORDER BY name;

# 07. Find Towns Not Starting With	

SELECT * FROM towns
WHERE LEFT(name, 1) NOT IN ("R", "B", "D")
ORDER BY name;

# 08. Create View Employees Hired After

CREATE VIEW `v_employees_hired_after_2000`
AS
SELECT first_name, last_name
FROM employees
WHERE YEAR(hire_date) > 2000;

SELECT * FROM v_employees_hired_after_2000;

# 09. Length of Last Name

SELECT first_name, last_name
FROM employees
WHERE CHAR_LENGTH(last_name) =5;

# 10. Countries Holding 'A'	

SELECT country_name, iso_code FROM countries
WHERE country_name LIKE("%a%a%a%")
ORDER BY iso_code;

# 11. Mix of Peak and River Names

SELECT peak_name, river_name,
LOWER(CONCAT(peak_name, SUBSTRING(river_name,2))) AS `mix`
FROM peaks, rivers
WHERE RIGHT(peak_name, 1) = LEFT(river_name, 1)
ORDER BY mix;

# 12. Games From 2011 and 2012 Year

SELECT name, 
DATE_FORMAT(start, '%Y-%m-%d')
FROM games
WHERE YEAR(start) IN (2011, 2012)
ORDER BY start, name
LIMIT 50;

# 13. User Email Providers

SELECT user_name, 
SUBSTRING(email, (LOCATE("@",email) +1)) AS `email provider`
FROM users
ORDER BY `email provider`, user_name;

# 14. Get Users with IP Address Like Pattern

SELECT user_name, ip_address
FROM users
WHERE ip_address LIKE "___.1%.%.___"
ORDER BY user_name;

# 15. Show All Games with Duration	

SELECT name, 
CASE
WHEN EXTRACT(HOUR FROM start)>=0 AND EXTRACT(HOUR FROM start)<12 THEN "Morning"
WHEN EXTRACT(HOUR FROM start)>=12 AND EXTRACT(HOUR FROM start)<18 THEN "Afternoon"
WHEN EXTRACT(HOUR FROM start)>= 18 AND EXTRACT(HOUR FROM start)<24 THEN "Evening"
END AS `Part of the day`,
CASE
WHEN duration<=3 THEN "Extra Short"
WHEN duration >3 AND duration<=6 THEN "Short"
WHEN duration>6 AND duration<=10 THEN "Long"
ELSE "Extra Long"
END AS `Duration` 
 FROM games;
 
 # 16. Orders Table	
 
  SELECT product_name, 
 order_date,
 DATE_ADD(order_date, INTERVAL 3 DAY) AS `pay_due`,
 DATE_ADD(order_date, INTERVAL 1 MONTH) AS`deliver_due`
 FROM orders;



