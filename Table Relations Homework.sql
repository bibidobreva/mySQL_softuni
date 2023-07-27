CREATE TABLE people(
person_id INT,
first_name VARCHAR(50) NOT NULL,
salary DECIMAL NOT NULL,
passport_id INT
);

INSERT INTO people 
VALUES(1, 'Roberto', 43300.00,102),
(2, 'Tom', 56100.00,103),
(3,'Yana', 60200.00, 101);

CREATE TABLE passports(
passport_id INT PRIMARY KEY UNIQUE,
passport_number VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO passports
VALUES (101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2');

ALTER TABLE people
ADD PRIMARY KEY AUTO_INCREMENT (person_id);

ALTER TABLE people
ADD CONSTRAINT unique_passport_id UNIQUE (passport_id),
ADD CONSTRAINT  `fk__people_passport_id_passports_passport_id`
FOREIGN KEY (passport_id)
REFERENCES passports(passport_id);


ALTER TABLE people
CHANGE COLUMN salary salary DECIMAL(10,2);








CREATE TABLE manufacturers(
manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
established_on DATE
);

INSERT INTO manufacturers
VALUES (1,'BMW','1916-03-01'),
(2,'Tesla','2003-01-01'),
(3,'Lada','1966-05-01');

CREATE TABLE models(
model_id INT PRIMARY KEY,
name VARCHAR(50),
manufacturer_id INT NOT NULL,
CONSTRAINT fk_models_manufacturs__manufactur_id 
FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(manufacturer_id)
);

INSERT INTO models
VALUES (101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3);











CREATE TABLE students(
student_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);


CREATE TABLE exams(
exam_id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);


CREATE TABLE students_exams(
student_id INT NOT NULL,
exam_id INT NOT NULL,
CONSTRAINT pk_students_exams PRIMARY KEY (student_id, exam_id),
CONSTRAINT fk__students_id__students_exam 
	FOREIGN KEY (student_id)
    REFERENCES students(student_id),
CONSTRAINT fk__exam_id__students_exam 
	FOREIGN KEY (exam_id)
    REFERENCES exams(exam_id)
);



INSERT INTO students VALUES
(1,'Mila'),
(2,'Toni'),
(3,'Ron');

INSERT INTO  exams VALUES
(101,'Spring MVC'),
(102,'Neo4j'),
(103,'Oracle 11g');

INSERT INTO  students_exams VALUES
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103);






CREATE TABLE teachers(
teacher_id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
manager_id INT
);

INSERT INTO teachers
VALUES (101,'John',NULL),
(102,'Maya',106),
(103,'Silvia',106),
(104,'Ted',105),
(105,'Mark',101),
(106,'Greta',101);


ALTER TABLE teachers
ADD CONSTRAINT fk_teacher_id_manager_id
FOREIGN KEY (manager_id)
REFERENCES teachers(teacher_id);







CREATE DATABASE `university`;
use `university`;

CREATE TABLE subjects(
subject_id INT PRIMARY KEY,
subject_name VARCHAR(50)
);

CREATE TABLE majors(
major_id INT PRIMARY KEY,
name VARCHAR(50)
);




CREATE TABLE students(
student_id INT PRIMARY KEY,
student_number VARCHAR(12),
student_name VARCHAR(50),
major_id INT,
CONSTRAINT fk_students_majors_major_id
FOREIGN KEY (major_id)
REFERENCES majors(major_id)
);

CREATE TABLE payments(
payment_id INT PRIMARY KEY,
payment_date DATE,
payment_amount DECIMAL(8,2),
student_id INT,
CONSTRAINT fk_payments_students_students_id
FOREIGN KEY (student_id)
REFERENCES students(student_id)
);


CREATE TABLE agenda(
student_id INT NOT NULL,
subject_id INT NOT NULL,
CONSTRAINT pk_student_subject PRIMARY KEY (student_id, subject_id),
CONSTRAINT fk_students_agenda__student_id
	FOREIGN KEY (student_id)
    REFERENCES students(student_id),
CONSTRAINT fk_subjects_agenda__subject_id
		FOREIGN KEY (subject_id)
        REFERENCES subjects(subject_id)
);










CREATE DATABASE `online`;
use `online`;


CREATE TABLE cities(
city_id INT PRIMARY KEY,
name VARCHAR(50));

CREATE TABLE item_types(
item_type_id INT PRIMARY KEY,
name VARCHAR(50)
);

CREATE TABLE items (
item_id INT PRIMARY KEY,
name VARCHAR(50),
item_type_id INT,
CONSTRAINT fk_items_item_type_item_id 
	FOREIGN KEY (item_type_id)
    REFERENCES item_types(item_type_id)
);


CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name VARCHAR(50),
birthday DATE,
city_id INT,
CONSTRAINT fk_customers_cities
	FOREIGN KEY (city_id)
    REFERENCES cities(city_id)
);


CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT,
CONSTRAINT fk_orders_customers__customer_id
	FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);


CREATE TABLE order_items(
order_id INT NOT NULL,
item_id INT NOT NULL,
CONSTRAINT pk_order_item PRIMARY KEY (order_id, item_id),
CONSTRAINT fk_order
	FOREIGN KEY (order_id)
    REFERENCES orders(order_id),
CONSTRAINT fk_item
	FOREIGN KEY (item_id)
    REFERENCES items(item_id)
);





use geography;

SELECT mountain_range, peak_name, elevation as 'peak_elevation'
FROM peaks
JOIN mountains ON peaks.mountain_id = mountains.id
WHERE mountain_range = 'Rila'
ORDER BY peak_elevation DESC;