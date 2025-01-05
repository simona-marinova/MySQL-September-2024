-- 2

INSERT INTO reviews (content, picture_url, published_at, rating)
SELECT
SUBSTRING(description, 1, 15),
REVERSE(name),
DATE("2010-10-10"),
price / 8
FROM products
WHERE id>=5;


-- 3

UPDATE products
SET quantity_in_stock = quantity_in_stock -5
WHERE quantity_in_stock BETWEEN 60 AND 70; 

--  4

DELETE FROM customers
WHERE id NOT IN (
SELECT customer_id 
FROM orders
);

-- 5

SELECT * FROM categories
ORDER BY name DESC;

-- 6

SELECT id, brand_id, name, quantity_in_stock
FROM products
WHERE price>1000 AND quantity_in_stock<30
ORDER BY quantity_in_stock, id;

-- 7

SELECT * FROM
reviews
WHERE content LIKE "My%" AND
CHAR_LENGTH(content) >61
ORDER BY rating DESC;

-- 8

SELECT
CONCAT(c.first_name, " ", c.last_name) AS full_name,
c.address,
o.order_datetime
FROM customers AS c
JOIN orders AS o
ON c.id = o.customer_id
WHERE YEAR(o.order_datetime)<=2018
ORDER BY full_name DESC;


-- 9

SELECT
COUNT(p.id),
 c.name,
 SUM(p.quantity_in_stock)
FROM products AS  p
JOIN categories AS c
ON p.category_id = c.id
GROUP BY p.category_id
ORDER BY COUNT(p.id) DESC,  SUM(p.quantity_in_stock)
LIMIT 5;


-- 10

DELIMITER $$
CREATE FUNCTION udf_customer_products_count(name VARCHAR(30)) 
RETURNS INT
DETERMINISTIC 
BEGIN
DECLARE number INT;
SET number :=(
SELECT 
COUNT(product_id)
FROM customers AS c
JOIN orders AS o
ON c.id = o.customer_id
JOIN orders_products AS o_p
ON o.id = o_p.order_id
WHERE c.first_name = name
GROUP BY first_name, last_name
);
RETURN number;
END$$
DELIMITER ;

-- 12


DELIMITER $$
CREATE PROCEDURE udp_reduce_price (category_name VARCHAR(50))
BEGIN
UPDATE products AS p
JOIN  categories AS c
ON p.category_id = c.id
JOIN reviews AS r
ON p.review_id = r.id
SET price = price - price*0.30 
WHERE r.rating <4 AND c.name = category_name;
END$$
DELIMITER ;








