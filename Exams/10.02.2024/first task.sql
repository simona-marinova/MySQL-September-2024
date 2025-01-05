CREATE TABLE continents (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE countries (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL UNIQUE,
country_code VARCHAR(10) NOT NULL UNIQUE,
continent_id INT NOT NULL,
CONSTRAINT fk_countries_continents
FOREIGN KEY (continent_id)
REFERENCES continents(id));


CREATE TABLE preserves (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL UNIQUE,
latitude DECIMAL(9,6),
longitude DECIMAL(9,6),
area INT,
type VARCHAR(20),
established_on DATE
);


CREATE TABLE positions (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT NULL UNIQUE,
description TEXT,
is_dangerous TINYINT(1)
);


CREATE TABLE workers (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(40) NOT NULL,
last_name VARCHAR(40) NOT NULL,
age INT,
personal_number VARCHAR(20) NOT NULL UNIQUE,
salary DECIMAL(19,2),
is_armed TINYINT(1) NOT NULL,
start_date DATE,
preserve_id INT,
position_id INT,
CONSTRAINT fk_workers_preserves
FOREIGN KEY (preserve_id)
REFERENCES preserves(id),
CONSTRAINT fk_workers_positions
FOREIGN KEY (position_id)
REFERENCES positions(id)
);

CREATE TABLE countries_preserves (
country_id INT,
preserve_id INT, 
KEY pk (country_id, preserve_id),
CONSTRAINT fk_countries_preserves_countries
FOREIGN KEY (country_id)
REFERENCES countries(id),
CONSTRAINT fk_countries_preserces_positions
FOREIGN KEY (preserve_id)
REFERENCES preserves (id)
);

