# Упражнение с Деси
# 1 задача
DELIMITER $$ 
CREATE PROCEDURE usp_get_employees_salary_above_35000 ()  
BEGIN
SELECT first_name, last_name FROM employees 
WHERE salary>35000
ORDER BY first_name, last_name, employee_id;
END$$ 

DELIMITER ;

CALL usp_get_employees_salary_above_35000 ();


# 2ра задача
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above (number DECIMAL(10,4))
BEGIN 
SELECT first_name, last_name
FROM employees 
WHERE salary >=number
ORDER BY first_name, last_name, employee_id;
END$$

CALL usp_get_employees_salary_above (45000);

DELIMITER ;


# 3та задача
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with ( town_name VARCHAR(50))
BEGIN 
SELECT name
FROM towns
WHERE name LIKE CONCAT(town_name, "%")
ORDER BY name;
END$$

DELIMITER ;

SELECT first_name, last_name
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
JOIN towns AS t
ON a.town_id = t.town_id
WHERE t.name = "sofia";


# 4та задача
DELIMITER $$

CREATE PROCEDURE usp_get_employees_from_town (town_name VARCHAR(50))
BEGIN
SELECT first_name, last_name
FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
JOIN towns AS t
ON a.town_id = t.town_id
WHERE t.name = town_name
ORDER BY e.first_name, e.last_name, e.employee_id;
END$$


# 5та задача
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level (salary DECIMAL(19,4)) 
RETURNS VARCHAR(10)
DETERMINISTIC 
BEGIN 
    DECLARE salary_level VARCHAR(10);
    IF salary < 30000 THEN SET salary_level := "Low";
    ELSEIF salary>=30000 AND salary<=50000 THEN SET salary_level := "Average";
	ELSE SET salary_level := "High";
	END IF;
    RETURN salary_level;
	END$$ 

DELIMITER ;

DROP FUNCTION ufn_get_salary_level;

# 6та задача

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(10))
BEGIN
SELECT first_name, last_name FROM employees
WHERE ufn_get_salary_level(salary) = salary_level
ORDER BY first_name DESC, last_name DESC;
END$$

# 7ма задача
DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))  
RETURNS INT
DETERMINISTIC 
BEGIN
RETURN word REGEXP (CONCAT("^[", set_of_letters, "]+$"));
END$$

DELIMITER ;

DROP PROCEDURE usp_get_holders_full_name;

# 8ма задача

DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN 
SELECT 
CONCAT(first_name, " ", last_name) AS full_name
FROM account_holders
ORDER BY full_name, id;
END$$ 


 
 # 9та задача
 DELIMITER $$
 CREATE PROCEDURE usp_get_holders_with_balance_higher_than (number DECIMAL(19,4))
 BEGIN 
 SELECT a_h.first_name, a_h.last_name
 FROM account_holders AS a_h
 LEFT JOIN accounts AS a
 ON a_h.id = a.account_holder_id
 GROUP BY first_name, last_name
 HAVING SUM(a.balance) > number;
 END$$
 DELIMITER ;

DROP FUNCTION ufn_calculate_future_value;

# 10та задача
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19,4), interest_rate DOUBLE, years INT)
RETURNS DECIMAL (19,4)
DETERMINISTIC 
BEGIN
    DECLARE future_sum DECIMAL(19,4);
    SET future_sum := sum * POW(1 + interest_rate, years);
    RETURN future_sum;
END$$
DELIMITER ;

DROP PROCEDURE usp_calculate_future_value_for_account;

# 11та задача
DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account  (id INT,  interest_rate DECIMAL(19,4))
BEGIN
SELECT
a.id AS `account_id`,
a_h.first_name, 
a_h.last_name,
a.balance AS `current_balance`,
ufn_calculate_future_value(a.balance, interest_rate, 5) AS balance_in_5_years
FROM accounts AS a
JOIN account_holders AS a_h
ON a_h.id = a.account_holder_id
WHERE a.id = id;
END$$
DELIMITER ;


# 12 та задача
SET SQL_SAFE_UPDATES =0;
DROP PROCEDURE usp_deposit_money;

DELIMITER $$
CREATE PROCEDURE usp_deposit_money(id INT, money_amount DECIMAL(19,4)) 
BEGIN 
START TRANSACTION;
IF (money_amount <=0) THEN ROLLBACK;
ELSE 
UPDATE accounts AS a
SET balance = balance + money_amount
WHERE a.id = id;
COMMIT; -- може да се пише, може да не се пише
END IF;
END$$
DELIMITER ;

 
 #13 та задача
 
 DROP PROCEDURE usp_withdraw_money;
 
 DELIMITER $$
  CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19,4))  
  BEGIN 
  START TRANSACTION;
  IF money_amount > (SELECT balance FROM accounts WHERE accounts.id = account_id) OR money_amount <=0 THEN ROLLBACK;
  ELSE 
  UPDATE accounts AS a
  SET a.balance = a.balance - money_amount
  WHERE a.id = account_id;
  COMMIT;
  END IF;
  END$$
DELIMITER ;


# 14та задача

DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19,4)) 
BEGIN
START TRANSACTION;
IF
from_account_id = to_account_id OR
amount <=0 OR
(SELECT balance FROM accounts WHERE from_account_id = id) < amount OR
(SELECT COUNT(id) FROM accounts WHERE from_account_id=id) =0 OR
(SELECT COUNT(id) FROM accounts WHERE to_account_id =id) =0
THEN ROLLBACK;
ELSE 
UPDATE accounts
SET balance = balance - amount
WHERE id = from_account_id;
UPDATE accounts
SET balance = balance + amount
WHERE id = to_account_id;
COMMIT;
END IF;
END$$
DELIMITER ;









