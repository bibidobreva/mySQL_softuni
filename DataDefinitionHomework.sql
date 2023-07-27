USE minions;
CREATE TABLE minions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    age VARCHAR(50)
);


CREATE TABLE towns (
    town_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

ALTER TABLE towns
RENAME COLUMN town_id TO id;

ALTER TABLE minions
ADD COLUMN town_id INT;

ALTER TABLE minions
ADD CONSTRAINT town_id_minion
FOREIGN KEY(town_id)
REFERENCES  towns(id);



INSERT towns(id,name)
VALUES
(1,'Sofia'),
(2,'Plovdiv'),
(3,'Varna');


INSERT minions(id,name, age, town_id)
VALUES
(1,'Kevin', 22, 1),
(2,'Bob', 15,3),
(3,'Steward',NULL,2);

TRUNCATE minions;

DROP TABLE  minions;
DROP TABLE  towns;

CREATE TABLE people (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height DECIMAL(5 , 2 ),
    weight DECIMAL(5 , 2 ),
    gender CHAR NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT
);

INSERT INTO people
VALUES
(1,'First', NULL, 10, 140, 'f', '2023-05-15', 'Here we write text') ,
(2,'Second', NULL, 10, 129, 'm', '2023-05-15', 'Here we write text') ,
(3,'Third', NULL, 10, 54, 'f', '2023-05-15', 'Here we write text') ,
(4,'Fourth', NULL, 10, 57, 'f', '2023-05-15', 'Here we write text') ,
(5,'Five', NULL, 10, 54, 'f', '2023-05-15', 'Here we write text') ;


CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(26) NOT NULL,
    profile_picture BLOB,
    last_login_time DATETIME,
    is_deleted BOOLEAN
);

insert into users(username,password)
values
('test1','test452'),
('test2','tehust2'),
('test','tesghjt2'),
('te21t1','tesrdt2'),
('tes65t1','testfgn2');


ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY (id, username);

ALTER TABLE users
CHANGE COLUMN last_login_time last_login_time datetime DEFAULT NOW();


ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY users(id),
CHANGE COLUMN username
username VARCHAR(30) UNIQUE;





CREATE DATABASE movies;
use movies;

CREATE TABLE directors(
id INT PRIMARY KEY AUTO_INCREMENT,
director_name VARCHAR(50) NOT NULL,
notes TEXT
);

insert into directors (director_name) values('Name'),('Name2'),('Name3'),('Name4'),('Name5');

CREATE TABLE genres(
id INT PRIMARY KEY AUTO_INCREMENT,
genre_name VARCHAR(50) NOT NULL,
notes TEXT
);

insert into genres (genre_name) values('Name'),('Name2'),('Name3'),('Name4'),('Name5');

CREATE TABLE categories(
id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(50) NOT NULL,
notes TEXT
);

insert into categories (category_name) values('Name'),('Name2'),('Name3'),('Name4'),('Name5');

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT,
    copyright_year YEAR,
    length DOUBLE,
    genre_id INT,
    category_id INT,
    rating DOUBLE(3 , 2 ),
    notes TEXT,
    FOREIGN KEY (director_id)
        REFERENCES directors (id),
    FOREIGN KEY (genre_id)
        REFERENCES genres (id),
    FOREIGN KEY (category_id)
        REFERENCES categories (id)
);

insert into movies (title, director_id, genre_id, category_id)
values
('test1', 1, 2, 4),
('test2', 1, 2, 5),
('222test', 4, 2, 4),
('tessst1', 1, 3, 4),
('tesfdt1', 3, 2, 3);











create database car_rental;


create table categories(
id INT PRIMARY KEY AUTO_INCREMENT, 
category VARCHAR(50) NOT NULL, 
daily_rate INT NOT NULL, 
weekly_rate INT, 
monthly_rate INT, 
weekend_rate INT);


insert into categories (category, daily_rate, weekly_rate)
values
('Car', 12, 13),
('Car', 22, 13),
('Bus', 12, 13);




CREATE TABLE cars(
id INT PRIMARY KEY AUTO_INCREMENT, 
plate_number VARCHAR(10) NOT NULL, 
make VARCHAR(50),
model VARCHAR(20), 
car_year YEAR, 
category_id INT NOT NULL, 
doors INT, 
picture BLOB, 
car_condition VARCHAR(50),
available boolean
);




insert into cars (plate_number, category_id)
values
(1223, 1),
(2132, 2),
(3211, 3);



CREATE  TABLE employees(
id INT PRIMARY KEY auto_increment,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50),
title VARCHAR (50) NOT NULL,
notes TEXT
);

insert into employees(first_name, title)
values
('Tony', 'Sales'),
('Tony', 'Sales'),
('Tony', 'Sales');



create table customers(
id INT PRIMARY KEY auto_increment, 
driver_licence_number VARCHAR(10) NOT NULL, 
full_name VARCHAR(50) NOT NULL, 
address VARCHAR(100), 
city VARCHAR(50), 
zip_code VARCHAR(10), 
notes TEXT
);


insert into customers (driver_licence_number, full_name)
values
('AS1245', 'Mia Alex'),
('AS1245', 'Mia Alex'),
('AS1245', 'Mia Alex');



create table rental_orders(
id INT PRIMARY KEY auto_increment, 
employee_id INT NOT NULL, 
customer_id INT NOT NULL, 
car_id INT NOT NULL, 
car_condition VARCHAR(50), 
tank_level INT,
kilometrage_start INT, 
kilometrage_end INT, 
total_kilometrage INT, 
start_date date, 
end_date date,
total_days INT, 
rate_applied INT, 
tax_rate FLOAT, 
order_status boolean, 
notes TEXT
);


insert into rental_orders (employee_id, customer_id, car_id)
values
(1, 2, 3),
(3,1,2),
(2,3,1);





create database  soft_uni;

create table towns(
id INT PRIMARY KEY auto_increment,
name VARCHAR(50) NOT NULL
);


create table addresses(
id INT PRIMARY KEY auto_increment,
address_text VARCHAR(100),
town_id int,
foreign key (town_id) 
references towns(id)
);


create table departments(
id INT PRIMARY KEY auto_increment,
name VARCHAR(50) NOT NULL
);


create table employees(
id INT PRIMARY KEY auto_increment,
first_name VARCHAR(50), 
middle_name VARCHAR(50), 
last_name VARCHAR(50), 
job_title VARCHAR(50), 
department_id int, 
hire_date date, 
salary decimal(10,2), 
address_id INT,
foreign key (department_id)
references departments(id),
foreign key (address_id)
references addresses(id)
);


insert into towns (name)
values 
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');


insert into departments (name)
values 
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');


insert into employees (first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
values 
( 'Ivan', 'Ivanov', 'Ivanov',	'.NET Developer',	4, '2013-02-01', 3500.00 ),
( 'Petar', 'Petrov', 'Petrov',	'Senior Engineer',	1,'2004-03-02', 4000.00),
( 'Maria', 'Petrova', 'Ivanova',	'Intern',	5,	'2016-08-28', 525.25 ),
( 'Georgi', 'Terziev', 'Ivanov', 'CEO',	2,'2007-12-09', 3000.00 ),
( 'Peter', 'Pan', 'Pan',	'Intern',	3,'2016-08-28',	599.88 );



select * from towns;
select * from departments;
select * from employees;

select * from towns 
order by name;

select * from departments
order by name;

select * from employees
order by salary desc;


select name from towns
order by name;

select name from departments
order by name;

select 
first_name, 
last_name,
job_title,
salary
from employees
order by salary desc;


update employees
set salary = salary*1.1;
select salary from employees;