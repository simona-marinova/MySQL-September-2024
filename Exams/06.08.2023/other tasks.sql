-- 2

INSERT INTO property_transactions ( property_id, buyer_id, transaction_date,
bank_name, iban, is_successful) 
SELECT 
(agent_id + DAY(offer_datetime)),
(agent_id + MONTH(offer_datetime)),
(offer_datetime),
CONCAT("Bank", " ", agent_id),
CONCAT("BG", price, agent_id),
(1)
FROM property_offers 
WHERE agent_id <=2;

-- 3
UPDATE properties
SET price = price - 50000
WHERE price >=800000;


-- 4

DELETE FROM property_transactions
WHERE is_successful = 0;


-- 5

SELECT * FROM agents
ORDER BY city_id DESC, phone DESC;

-- 6

SELECT * FROM property_offers
WHERE YEAR(offer_datetime) = "2021"
ORDER BY price
LIMIT 10;

-- 7

SELECT 
SUBSTRING(address, 1,6) AS agent_name,
CHAR_LENGTH(address)*5430 AS price
FROM properties AS p
WHERE id NOT IN (
SELECT property_id
FROM property_offers)
ORDER BY agent_name DESC, price DESC;

-- 8

SELECT bank_name,
COUNT(iban) AS count
FROM property_transactions
GROUP BY bank_name
HAVING count>=9
ORDER BY count DESC, bank_name;


-- 9

SELECT address,
area,
CASE
WHEN area <=100 THEN "small"
WHEN area <= 200 THEN "medium"
WHEN area<=500 THEN "large"
ELSE "extra large"
END AS size
FROM properties
ORDER BY area, address DESC;

-- 11


DELIMITER $$

CREATE FUNCTION udf_offers_from_city_name (cityName VARCHAR(50)) 
RETURNS INT
DETERMINISTIC
BEGIN
DECLARE count INT;
SET count := (
SELECT COUNT(*)
FROM property_offers AS p_o
JOIN properties AS p
ON p_o.property_id = p.id
JOIN cities AS c
ON p.city_id = c.id
GROUP BY c.name
HAVING c.name = cityName
);
RETURN count;
END$$
DELIMITER ;

-- 12


DELIMITER $$
CREATE PROCEDURE udp_special_offer (first_name VARCHAR(50))
BEGIN 
UPDATE property_offers AS p_o
JOIN agents AS a
ON p_o.agent_id = a.id
SET price = price - price*0.10
WHERE a.first_name = first_name;
END$$
DELIMITER ;




