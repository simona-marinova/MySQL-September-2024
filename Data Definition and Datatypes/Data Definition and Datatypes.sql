# Data Definition and Data Types

# 01. Create Tables	

CREATE TABLE minions (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
name VARCHAR(50),
age INT
);

CREATE TABLE towns (
town_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
name VARCHAR(50)
);

# 02. Alter Minions Table	

ALTER TABLE minions 
ADD COLUMN town_id INT;

ALTER TABLE minions
ADD CONSTRAINT fk_town_id
FOREIGN KEY(town_id) REFERENCES towns (id);


# 03. Insert Records in Both Tables	

INSERT INTO towns (id, name) VALUES 
(1, "Sofia"),
(2, "Plovdiv"),
(3, "Varna");

INSERT INTO minions VALUES
(1, "Kevin", 22, 1),
(2, "Bob", 15, 3),
(3, "Steward", NULL, 2);

# 04. Truncate Table Minions	

TRUNCATE TABLE minions;

# 05. Drop All Tables	

DROP TABLE minions;
DROP TABLE towns;

# 06. Create Table People	

CREATE TABLE people (
id INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(200) NOT NULL,
picture TEXT,
height DOUBLE(10,2), 
weight DOUBLE (10,2),
gender CHAR(1) NOT NULL,
birthdate DATE NOT NULL,
biography TEXT
);

INSERT INTO people VALUES 
(1, "Ivan", "TEST", 1.50, 53, "f", "1995-01-20", "123"),
(2, "Ivan", "TEST", 1.50, 53, "f", "1995-01-20", "123"),
(3, "Dragan", "TEST", 1.50, 53, "m", "1995-01-20", "123"),
(4, "Petka", "TEST", 1.70, 53, "f", "1995-01-20", "123"),
(5, "Vasilena", "TEST", 1.75, 53, "f", "1995-01-20", "123");

# 07. Create Table Users	

CREATE TABLE users (
id INT UNIQUE PRIMARY KEY AUTO_INCREMENT NOT NULL,
username VARCHAR(30) NOT NULL,
password VARCHAR (26),
profile_picture TEXT,
last_login_time DATETIME,
is_deleted BOOLEAN
);

INSERT INTO users VALUES
(1, "moni", 26, "TEXT", "2024-05-30 20:11:11", false),
(2, "moni", 26, "TEXT", "2024-05-30 20:11:11", false),
(3, "moni", 26, "TEXT", "2024-05-30 20:11:11", false),
(4, "moni", 26, "TEXT", "2024-05-30 20:11:11", false),
(5, "moni", 26, "TEXT", "2024-05-30 20:11:11", false);


# 08. Change Primary Key	

ALTER TABLE users 
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY (id, username);


# 9. Set Default Value of a Field	

ALTER TABLE users 
CHANGE COLUMN last_login_time last_login_time DATETIME DEFAULT NOW();

# 10. Set Unique Field	

ALTER TABLE users
DROP PRIMARY KEY,
ADD PRIMARY KEY (id);

ALTER TABLE users
MODIFY username VARCHAR(30) NOT NULL UNIQUE;

# 11. Movies Database	

CREATE TABLE directors (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
director_name VARCHAR(100),
notes TEXT
);

CREATE TABLE genres (
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL UNIQUE,
genre_name VARCHAR(100) NOT NULL,
notes TEXT
);


CREATE TABLE categories (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
category_name VARCHAR(100) NOT NULL,
notes TEXT
);


CREATE TABLE movies (
id INT PRIMARY KEY NOT NULL UNIQUE AUTO_INCREMENT,
 title VARCHAR(255) NOT NULL, 
 director_id INT, 
 copyright_year DATE, 
 length DOUBLE(10,2), 
 genre_id VARCHAR(50), 
 category_id INT,
 rating DOUBLE (5,2), 
 notes TEXT
);

INSERT INTO directors (director_name, notes) VALUES
("Gosho", "text"),
("Pesho", "text"),
("Ivan", "text"),
("Georgi", "text"),
("Moni", "text");


INSERT INTO genres (genre_name, notes) VALUES
("Horror", "text"),
("Comedy", "text"),
("Science-fiction", "text"),
("Documentary", "text"),
("TV Series", "text");


INSERT INTO categories (category_name, notes) VALUES
("Romance", "text"),
("Drama", "text"),
("Crime", "text"),
("Adventure", "text"),
("Thriller", "text");

INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes) VALUES
("Avatar", 1, "2020-03-05", 2.30, 5, 2, 9.5, "text"),
("The Little Mermaid", 2, "2020-03-05", 2.30, 8, 2, 9.5, "text"),
("The game", 3, "2020-03-05", 4.00, 9, 2, 9.5, "text"),
("The hunger games", 4, "2020-03-05", 2.45, 3, 2, 9.5, "text"),
("The little duck", 5, "2020-03-05", 3.50, 7, 2, 9.5, "text");


# 12. Car Rental Database	

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL, 
category VARCHAR(100),
daily_rate DOUBLE(10,2),
weekly_rate DOUBLE (10,2),
monthly_rate DOUBLE (10,2),
weekend_rate DOUBLE (10,2)
);

CREATE TABLE cars (
id INT PRIMARY KEY AUTO_INCREMENT UNIQUE NOT NULL, 
plate_number VARCHAR(10),
make VARCHAR(100),
model VARCHAR (100), 
car_year DATE,
category_id INT,
doors INT,
picture BLOB,
car_condition VARCHAR(100),
available BOOLEAN
);

CREATE TABLE employees (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
first_name VARCHAR(50), 
last_name VARCHAR(50),
title VARCHAR(100), 
notes TEXT
);

CREATE TABLE customers (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE,
driver_licence_number INT, 
full_name VARCHAR(200),
address VARCHAR(255) , 
city VARCHAR (50) , 
zip_code INT, 
notes TEXT
);

CREATE TABLE rental_orders (
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT UNIQUE, 
employee_id INT, 
customer_id INT, 
car_id INT,
car_condition VARCHAR(100), 
tank_level DOUBLE (5,2), 
kilometrage_start INT, 
kilometrage_end INT, 
total_kilometrage INT, 
start_date DATE, 
end_date DATE, 
total_days INT, 
rate_applied DOUBLE(10,2), 
tax_rate DOUBLE (10,2), 
order_status VARCHAR(50),
notes TEXT
);

INSERT INTO categories (category, daily_rate, weekly_rate, monthly_rate, weekend_rate) VALUES
("bus", 9.80, 10.20, 35.50, 25.10),
("car", 9.80, 10.20, 35.50, 25.10),
("train", 9.80, 10.20, 35.50, 25.10);

INSERT INTO cars ( plate_number, make, model, car_year, category_id, doors, picture, car_condition, available) VALUES
("SV", "Lada", "combi", "1850-12-05", 4, 4, "picture", "bad", true),
("LDK", "Lada", "combi", "1850-12-05", 4, 4, "picture", "bad", false),
("GHDK", "Lada", "combi", "1850-12-05", 4, 4, "picture", "bad", true);


INSERT INTO employees (first_name, last_name, title, notes) VALUES 
("Simona", "Marinova", "Worker", "text"),
("Dimana", "Marinova", "Worker", "text"),
("Galina", "Marinova", "Worker", "text");

INSERT INTO customers (driver_licence_number, full_name, address, city, zip_code, notes) VALUES 
(56, "Simona Marinova", "Georgi Kirkov", "Shumen", 9700, "text"),
(79, "Ivana Marinova", "Georgi Kirkov", "Shumen", 9700, "text"),
(25, "Gergana Marinova", "Georgi Kirkov", "Shumen", 9700, "text");

INSERT INTO rental_orders ( employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes) VALUES
(1,2,3, "bad", 25.30, 20, 30, 50, "2023-12-01", "2024-02-27", 56, 20.20, 30.30, "finished", "text"),
(4,2,3, "bad", 25.30, 20, 30, 50, "2023-12-01", "2024-02-27", 56, 20.20, 30.30, "finished", "text"),
(6, 2,3, "bad", 25.30, 20, 30, 50, "2023-12-01", "2024-02-27", 56,  20.20, 30.30, "finished", "text");

# 13. Basic Insert	

INSERT INTO towns (name) VALUES
("Sofia"),
("Plovdiv"),
("Varna"),
("Burgas");
 
 
 INSERT INTO departments (name) VALUES
 ("Engineering"), 
 ("Sales"), 
 ("Marketing"), 
 ("Software Development"),
 ("Quality Assurance");
 
 INSERT INTO employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary) VALUES
 ("Ivan", "Ivanov", "Ivanov", ".NET Developer", 4, "2013-02-01", 3500.00),
 ("Petar", "Petrov", "Petrov", "Senior Engineer", 1, "2004-03-02", 4000.00),
 ("Maria", "Petrova", "Ivanova", "Intern", 5, "2016-08-28", 525.25),
 ("Georgi", "Terziev", "Ivanov", "CEO", 2, "2007-12-09", 3000.00),
 ("Peter", "Pan", "Pan", "Intern", 3, "2016-08-28", 599.88);
 
 # 14. Basic Select All Fields	
 
 SELECT * FROM towns;
SELECT * from departments;
SELECT * FROM employees; 

# 15. Basic Select All Fields and Order Them	

SELECT * FROM towns ORDER BY name;
SELECT * from departments ORDER by name;
SELECT * FROM employees ORDER BY SALARY DESC;

# 16. Basic Select Some Fields	

SELECT name FROM towns ORDER BY name;
SELECT name FROM departments ORDER BY name;
SELECT first_name, last_name, job_title, salary FROM employees ORDER BY SALARY DESC;

# 17. Increase Employees Salary	

UPDATE employees SET salary = salary*1.10;
SELECT salary FROM employees;