CREATE DATABASE exercise;

CREATE TABLE passports (
passport_id INT PRIMARY KEY AUTO_INCREMENT,
passport_number VARCHAR(50) UNIQUE
);

INSERT INTO passports (passport_id, passport_number)
VALUES 
 (101, "N34FG21B"),
 (102, "K65LO4R7"),
 (103, "ZE657QP2");


CREATE TABLE people(
person_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50), 
salary DECIMAL(9,2), 
passport_id INT UNIQUE,
CONSTRAINT fk_people_passports
FOREIGN KEY (passport_id)
REFERENCES passports (passport_id)
);

 
INSERT INTO people (person_id, first_name, salary, passport_id)
VALUES 
 (1 , "Roberto", 43300.00, 102),
(2, "Tom", 56100.00, 103),
(3, "Yana",	60200.00, 101);

CREATE DATABASE cars;

CREATE TABLE `manufacturers` (
`manufacturer_id`	INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL UNIQUE, 
`established_on` DATE
);

INSERT INTO `manufacturers` (name, established_on) VALUES 
("BMW", "1916-03-01"),
("Tesla","2003-01-01"),
("Lada", "1966-05-01");

CREATE TABLE models (
model_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
manufacturer_id INT,
CONSTRAINT fk_models_manufacturers
FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers (manufacturer_id)
);

INSERT INTO models VALUES 
(101, "X1",	1),
(102, "i6",	1),
(103, "Model S", 2),
(104, "Model X", 2),
(105, "Model 3", 2),
(106, "Nova", 3);


CREATE DATABASE `school`;

CREATE TABLE exams (
exam_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);

ALTER TABLE exams AUTO_INCREMENT = 101;

CREATE TABLE students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL
);

INSERT INTO exams (name) VALUES 
("Spring MVC"),
("Neo4j"),
("Oracle 11g");

INSERT INTO students (name) VALUES
("Mila"),                                 
("Toni"),
("Ron");

CREATE TABLE students_exams (
student_id INT NOT NULL,
exam_id INT NOT NULL,
CONSTRAINT pk_students_exams
PRIMARY KEY (student_id, exam_id),
CONSTRAINT fk_students_student_id_exams_exam_id
FOREIGN KEY (student_id)
REFERENCES students (student_id),
CONSTRAINT fk_students_exam_id_exams_exam_id
FOREIGN KEY (exam_id)
REFERENCES exams (exam_id)
);

INSERT INTO students_exams VALUES
(1,	101),
(1, 102),
(2,	101),
(3,	103),
(2,	102),
(2,	103);

CREATE DATABASE teachers;

CREATE TABLE teachers (
teacher_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL, 
manager_id INT
);

ALTER TABLE teachers AUTO_INCREMENT = 101;

INSERT INTO eachers (name, manager_id) VALUES 
("John", NULL),
("Maya", 106),
("Silvia", 106),
("Ted",	105),
("Mark", 101),
("Greta", 101);


ALTER TABLE teachers
ADD CONSTRAINT fk
FOREIGN KEY (manager_id)
REFERENCES teachers (teacher_id);

# 6та задача:
CREATE DATABASE university;

CREATE TABLE subjects (
subject_id INT(11) PRIMARY KEY AUTO_INCREMENT,
subject_name VARCHAR (50) 
);

CREATE TABLE majors (
major_id INT(11) PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) 
);

CREATE TABLE payments (
payment_id INT(11) PRIMARY KEY AUTO_INCREMENT,
payment_date DATE,
payment_amount DECIMAL(8,2),
student_id INT(11)
);

CREATE TABLE students (
student_id INT(11) PRIMARY KEY AUTO_INCREMENT,
student_number VARCHAR(12) UNIQUE,
student_name VARCHAR(50),
major_id INT(11)
);


CREATE TABLE agenda(
student_id INT(11),
subject_id INT(11),
CONSTRAINT pk
PRIMARY KEY (student_id, subject_id)
);

ALTER TABLE payments
ADD CONSTRAINT fk_payments_students
FOREIGN KEY (student_id)
REFERENCES students (student_id);

ALTER TABLE students
ADD CONSTRAINT fk_students_majors
FOREIGN KEY (major_id)
REFERENCES majors (major_id);

ALTER TABLE agenda 
ADD CONSTRAINT fk_agenda_subjects
FOREIGN KEY (subject_id)
REFERENCES subjects(subject_id);

ALTER TABLE agenda
ADD CONSTRAINT fk_agenda_students
FOREIGN KEY (student_id)
REFERENCES students (student_id);









