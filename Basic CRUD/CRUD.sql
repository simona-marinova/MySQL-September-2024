#  Basic CRUD

# 01. Find All Information About Departments	

SELECT * FROM departments
ORDER BY department_id;

# 02. Find all Department Names	

SELECT name FROM departments
ORDER BY department_id;

# 03. Find Salary of Each Employee	

SELECT first_name, last_name, salary
FROM employees
ORDER BY employee_id;

# 04. Find Full Name of Each Employee	

SELECT 
    first_name, middle_name, last_name
FROM
    employees
ORDER BY employee_id;

#  5. Find Email Address of Each

SELECT 
CONCAT (first_name, ".", last_name, "@softuni.bg") AS `full_email_address`
FROM employees;


# 06. Find All Different Employee’s Salaries	

SELECT DISTINCT salary
FROM employees;

# 07. Find all Information About Employees

SELECT * FROM employees
WHERE job_title = "Sales Representative"
ORDER BY employee_id;

# 08. Find Names of All Employees by Salary in Range	

SELECT first_name, last_name, job_title
FROM employees
WHERE salary >=20000 AND salary<=30000;

# 08. Find Names of All Employees by Salary in Range	

SELECT first_name, last_name, job_title
FROM employees
WHERE salary BETWEEN 20000 AND 30000;


