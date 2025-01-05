CREATE DATABASE airlines_db;

DROP DATABASE airlines_db;

CREATE TABLE countries(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(30) NOT NULL UNIQUE,
description TEXT,
currency VARCHAR(5) NOT NULL
);

CREATE TABLE airplanes (
id INT PRIMARY KEY AUTO_INCREMENT,
model VARCHAR(50) NOT NULL UNIQUE,
passengers_capacity INT NOT NULL,
tank_capacity DECIMAL(19, 2) NOT NULL,
cost DECIMAL(19,2) NOT NULL
);

CREATE TABLE passengers (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
country_id INT NOT NULL,
CONSTRAINT fk_passengers_countries
FOREIGN KEY (country_id)
REFERENCES countries(id)
);


CREATE TABLE flights (
id INT PRIMARY KEY AUTO_INCREMENT,
flight_code VARCHAR(30) NOT NULL UNIQUE,
departure_country INT NOT NULL,
destination_country INT NOT NULL,
airplane_id INT NOT NULL,
has_delay TINYINT(1),
departure DATETIME,
CONSTRAINT fk_flights_countries_departure
FOREIGN KEY (departure_country)
REFERENCES countries(id),
CONSTRAINT fk_flights_countries_destination
FOREIGN KEY (destination_country)
REFERENCES countries(id),
CONSTRAINT fk_flights_airplanes
FOREIGN KEY(airplane_id)
REFERENCES airplanes(id)
);

CREATE TABLE flights_passengers (
flight_id INT,
passenger_id INT,
KEY(flight_id, passenger_id),
CONSTRAINT fk_flights_passengers_flights
FOREIGN KEY (flight_id)
REFERENCES flights(id),
CONSTRAINT fk_flights_passengers_passengers
FOREIGN KEY (passenger_id)
REFERENCES passengers (id)
);