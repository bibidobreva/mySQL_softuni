CREATE database softuni_taxi;
USE softuni_taxi;

create table addresses (
id int PRIMARY key AUTO_INCREMENT,
name VARCHAR(100) not null
);


create table categories(
id int primary key AUTO_INCREMENT,
name VARCHAR(10) not null
);


create table clients(
id int PRIMARY key AUTO_INCREMENT,
full_name VARCHAR(50) not null,
phone_number VARCHAR(20) not null
);

create table drivers(
id int primary key AUTO_INCREMENT,
first_name VARCHAR(30) not null, 
last_name VARCHAR(30) not null,
age int not null,
rating float DEFAULT 5.5 not null
);


CREATE table cars(
id INT PRIMARY KEY AUTO_INCREMENT,
make VARCHAR(20) not null,
model VARCHAR(20) not null,
year int DEFAULT 0 not null,
mileage int DEFAULT 0 ,
`condition` CHAR(1) not null,
category_id int not null,
CONSTRAINT fk_cars_id_category_id
FOREIGN KEY (category_id)
REFERENCES categories(id)
);


create table courses(
id int primary key AUTO_INCREMENT,
from_address_id int NOT null,
start datetime not null,
bill DECIMAL(10,2) DEFAULT 10,
car_id int not null,
client_id int not null,
CONSTRAINT fk_courses_address_id
FOREIGN KEY (from_address_id)
REFERENCES addresses(id),
CONSTRAINT fk_courses_car_id
FOREIGN KEY(car_id)
REFERENCES cars(id),
CONSTRAINT fk_courses_client_id
FOREIGN KEY (client_id)
REFERENCES clients(id)
);



create table cars_drivers(
car_id int not null,
driver_id int not null,
CONSTRAINT pk_cars_drivers PRIMARY KEY (car_id, driver_id),
CONSTRAINT fk_card_drivers_car_id
FOREIGN KEY (car_id)
REFERENCES cars(id),
CONSTRAINT fk_cars_drivers_driver_id
FOREIGN KEY (driver_id)
REFERENCES drivers(id)
);



INSERT INTO clients(full_name, phone_number)
SELECT concat_ws(' ', first_name, last_name), concat('(088) 9999',id*2)
FROM drivers
WHERE id BETWEEN 10 and 20;



UPDATE cars
SET `condition` = 'C'
WHERE mileage >=800000  or mileage is null 
	and year <= 2010
    and make != 'Mercedes-Benz';
    
    
    
    DELETE clients from clients
    LEFT JOIN courses on  courses.client_id = clients.id
    WHERE courses.id IS NULL  AND char_length(full_name)>3;



SELECT make, model, `condition` FROM cars
ORDER BY id;


SELECT first_name, last_name, make, model, mileage
FROM drivers
JOIN cars_drivers ON cars_drivers.driver_id = drivers.id
JOIN cars On cars.id = cars_drivers.car_id
WHERE mileage is not null
ORDER BY mileage DESC, first_name;


SELECT cars.id as 'car_id', make, mileage, count(courses.id) as 'count_of_courses',
	round(avg(bill) ,2) 'avg_bill'
FROM cars
LEFT JOIN courses on cars.id = courses.car_id
GROUP BY cars.id
HAVING `count_of_courses` !=2
ORDER BY `count_of_courses` DESC, cars.id;
    
    
SELECT full_name, count(courses.car_id) as 'count_of_cars', sum(courses.bill) as 'total_sum'
FROM clients
JOIN courses on courses.client_id = clients.id
WHERE full_name LIKE '_a%'
GROUP BY clients.id
HAVING `count_of_cars` >1
ORDER BY full_name;



SELECT addresses.name as 'name',
	(CASE
		when hour(start) BETWEEN 6 and 20 THEN 'Day'
        ELSE  'Night' END) as 'day_time',
        bill,
        clients.full_name,
        make,
        model,
        categories.name as 'category_name'
FROM courses
JOIN addresses on addresses.id = courses.from_address_id
JOIN clients on clients.id = courses.client_id
JOIN cars on cars.id = courses.car_id
JOIN categories on categories.id = cars.category_id
ORDER BY courses.id;





DELIMITER $$

CREATE FUNCTION  udf_courses_by_client (phone_num VARCHAR (20))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN(SELECT count(courses.id) as 'count'
			FROM courses
            JOIN clients on courses.client_id =clients.id
             WHERE phone_num = phone_number);
    END$$
    
    
    
    CREATE PROCEDURE udp_courses_by_address (address_name VARCHAR(100))
    BEGIN 
     SELECT addresses.name,
			clients.full_name,
            (CASE
				WHEN bill <=20 THEN 'Low'
                WHEN bill <30 THEN 'Medium'
                ELSE 'High'
                END) as 'level_of_bill',
                make,
                `condition`,
                categories.name as 'cat_name'
      FROM addresses
      JOIN courses on addresses.id = courses.from_address_id
      JOIN cars on courses.car_id = cars.id
      JOin clients on clients.id = courses.client_id
      JOIN categories on categories.id = cars.category_id
      WHERE addresses.name = address_name
      ORDER BY make, full_name;
      END$$
