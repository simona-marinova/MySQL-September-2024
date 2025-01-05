DROP FUNCTION ufn_count_employees_by_town;

DELIMITER $$
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50)) 
RETURNS INT 
READS SQL DATA
BEGIN
DECLARE e_count INT;
SET e_count :=
 (SELECT COUNT(*) AS `count`
FROM employees AS e
JOIN addresses a
ON e.address_id = a.address_id
JOIN towns t ON a.town_id = t.town_id
WHERE t.name = town_name);
RETURN e_count;
END$$

DELIMITER ;

SELECT ufn_count_employees_by_town("Sofia");

DELIMITER $$
CREATE PROCEDURE usp_select_employees()
BEGIN 
SELECT first_name, last_name FROM employees;
END$$

DELIMITER ;

CALL usp_select_employees();

SET @asd =10;
SELECT @asd;
SET @asd = "Not text";
SELECT @asd;

SET @emp_count = (SELECT COUNT(*) FROM employees);

SELECT @emp_count;

DELIMITER $$
CREATE PROCEDURE usp_with_out_param(OUT answer INT)
BEGIN 
SET answer = FLOOR(RAND() * 10);
END $$
DELIMITER ;

CALL usp_with_out_param(@asd);
SELECT (@asd);

CALL usp_with_out_param(@brand_new);
SELECT @brand_new;

SELECT e.first_name, e.salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
WHERE d.name = "Finance"
ORDER BY e.first_name, e.salary;

UPDATE employees e
SET e.salary = e.salary * 1.05
WHERE e.department_id = (
SELECT d.department_id FROM departments d
WHERE d.name = "Finance"
);


DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
UPDATE employees e
SET e.salary = e.salary * 1.05
WHERE e.department_id = (
SELECT d.department_id FROM departments d
WHERE d.name = department_name
);
END$$

DELIMITER ;

CALL usp_raise_salaries("Finance");


DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT) 
BEGIN
DECLARE e_cnt INT;
SET e_cnt := (SELECT COUNT(*) FROM employees WHERE employee_id=id);
START TRANSACTION;
-- говорим за модифициращи операции update, delete, insert
-- всяка транзакция стига или до ROLLBACK или до COMMIT
UPDATE employees 
SET salary = salary*1.05
WHERE employee_id = id;
IF (e_cnt =0) THEN
ROLLBACK;
ELSE COMMIT;
END IF;
END $$
DELIMITER ;

CALL usp_raise_salary_by_id(43);

DELIMITER $$
CREATE TRIGGER tr_add_town_address
AFTER INSERT
ON towns
FOR EACH ROW
INSERT INTO addresses (address_text, town_id)
VALUES (CONCAT(NEW.name, "Center"), NEW.town_id);
END$$

DELIMITER ;

INSERT INTO towns (name) VALUES ("New"), ("Old");

SELECT * FROM towns
ORDER BY town_id DESC;

SELECT * FROM addresses
ORDER BY address_id DESC;


CREATE TABLE deleted_employees AS SELECT 
employee_id ,
first_name, 
last_name ,
middle_name,
job_title ,
department_id,
salary
FROM employees;


DELIMITER $$
CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
INSERT INTO deleted_employees VALUES 
( OLD.employee_id, OLD.first_name, OLD.middle_name, OLD.last_name, OLD.job_title, OLD.department_id, OLD.salary);
END$$
DELIMITER ;

DELETE FROM employees
WHERE employee_id=43;