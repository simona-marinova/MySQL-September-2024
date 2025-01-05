-- 2

INSERT INTO products (name, type, price)
SELECT 
CONCAT(last_name, " ", "specialty"),
"Cocktail",
CEILING(0.01*salary)
FROM waiters
WHERE id>6;

-- 3

UPDATE orders
SET table_id = table_id - 1
WHERE id BETWEEN 12 AND 23;

-- 4 

DELETE FROM waiters
WHERE id NOT IN (SELECT waiter_id FROM orders);

-- 5

SELECT * FROM clients
ORDER BY birthdate DESC, id DESC;

-- 6

SELECT first_name, 
last_name,
birthdate,
review 
FROM clients
WHERE card IS NULL AND YEAR(birthdate) BETWEEN 1978 AND 1993
ORDER BY last_name DESC, id
LIMIT 5;

-- 7

SELECT 
CONCAT(last_name, first_name, CHAR_LENGTH(first_name),"Restaurant")  AS username,
REVERSE(SUBSTRING(email,2, 12)) AS password 
FROM waiters WHERE salary IS NOT NULL
ORDER BY password DESC;

-- 8

SELECT p.id, p.name,
COUNT(o_p.order_id) AS count
FROM products AS p
JOIN orders_products AS o_p
ON p.id = o_p.product_id
GROUP BY product_id
HAVING count>=5
ORDER BY count DESC, p.name;

-- 9

SELECT o.table_id,
t.capacity,
COUNT(o_c.client_id) AS count,
CASE 
WHEN t.capacity > COUNT(o_c.client_id) THEN "Free seats"
WHEN t.capacity = COUNT(o_c.client_id) THEN "Full"
ELSE "Extra seats"
END AS availability
FROM orders_clients AS o_c
JOIN orders AS o
ON o.id = o_c.order_id
JOIN tables AS t
ON t.id = o.table_id
WHERE t.floor =1
GROUP BY o.table_id
ORDER BY o.table_id DESC;


-- 10

DELIMITER $$
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50))  
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN
DECLARE price DECIMAL(19,2);
SET price := (SELECT
SUM(p.price)
FROM clients AS c
JOIN orders_clients AS o_c
ON c.id = o_c.client_id
JOIN orders AS o
ON o.id = o_c.order_id
JOIN orders_products AS o_p
ON o.id = o_p.order_id
JOIN products AS p
ON o_p.product_id = p.id
WHERE CONCAT(first_name, " ", last_name) = full_name
GROUP BY c.id);
RETURN price;
END$$
DELIMITER ;


-- 11


DELIMITER $$
CREATE PROCEDURE udp_happy_hour (type VARCHAR(50))
BEGIN
SET SQL_SAFE_UPDATES =0;
UPDATE products AS p
SET price = price - 0.2*price
WHERE p.type = type  AND price>=10;
END$$
DELIMITER ;
