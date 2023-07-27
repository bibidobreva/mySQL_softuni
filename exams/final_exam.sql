

create table countries(
id int primary key AUTO_INCREMENT,
name VARCHAR(40) not null UNIQUE
);


create table cities(
id int primary key AUTO_INCREMENT,
name VARCHAR(40) not null UNIQUE,
population int,
country_id int not null,
CONSTRAINT fk_cities_countries_id
FOREIGN KEY(country_id)
REFERENCES countries(id)
);


create table universities(
id int PRIMARY key AUTO_INCREMENT,
name VARCHAR(60) not null UNIQUE,
address VARCHAR(80) not null UNIQUE,
tuition_fee DECIMAL(19,2) not null,
number_of_staff int,
city_id int,
CONSTRAINT fk_universities_city_id
FOREIGN KEY(city_id)
REFERENCES cities(id)
);


create table students(
id int primary key AUTO_INCREMENT,
first_name VARCHAR(40) not null,
last_name VARCHAR(40) not null,
age int,
phone VARCHAR(20) not null UNIQUE,
email VARCHAR(255) not null UNIQUE,
is_graduated TINYINT(1) not null,
city_id INT,
CONSTRAINT fk_students_city_id
FOREIGN KEY(city_id)
REFERENCES cities(id)
);


CREATE table courses(
id int primary key AUTO_INCREMENT,
name VARCHAR(40) not null UNIQUE,
duration_hours DECIMAL(19,2),
start_date date,
teacher_name VARCHAR(60) not null UNIQUE,
description TEXT,
university_id INT,
CONSTRAINT fk_courses_university_id
FOREIGN KEY (university_id)
REFERENCES universities(id)
);


CREATE table students_courses(
grade DECIMAL(19,2) not null,
student_id int not null,
course_id int not null,
CONSTRAINT fk_students_courses_student_id
FOREIGN KEY(student_id)
REFERENCES students(id),
CONSTRAINT fk_students_courses_course_id
FOREIGN KEY(course_id)
REFERENCES courses(id)
);


INSERT INTO courses(name, duration_hours, start_date, teacher_name, description, university_id)
SELECT concat(teacher_name, ' ', 'course'),
	char_length(name)/10,
    DATE_ADD(start_date, INTERVAL 5 DAY),
    reverse(teacher_name),
    concat('Course',' ', teacher_name, reverse(description)),
    day(start_date)
FROM courses    
WHERE id <=5;    



UPDATE universities
SET tuition_fee = tuition_fee+300
WHERE id BETWEEN 5 and 12;

	
    
DELETE  universities FROM universities
WHERE number_of_staff IS NULL;






SELECT id, name, population, country_id 
FROM cities
ORDER BY population DESC;



SELECT first_name, last_name, age, phone, email
FROM students
WHERE age>=21
ORDER BY first_name DESC, email, id
LIMIT 10;



SELECT concat_ws(' ', first_name, last_name) as 'full_name',	
		substr(email, 2, 10) as 'username',
        reverse(phone) as 'password'
FROM students
LEFT JOIN  students_courses    on students.id = students_courses.student_id
WHERE course_id is null
ORDER BY `password` DESC;


SELECT count(students_courses.student_id) as 'students_count',
universities.name as 'university_name'
FROM universities
JOIN courses on courses.university_id = universities.id
JOIN students_courses on students_courses.course_id = courses.id
GROUP BY universities.name
HAVING `students_count` >=8
ORDER BY `students_count` DESC, `university_name` DESC;


SELECT universities.name as 'university_name',
		cities.name as 'city_name',
        address,
        (CASE 
				WHEN tuition_fee <800 THEN 'cheap'
                WHEN tuition_fee >=800 and tuition_fee <1200 THEN 'normal'
                WHEN tuition_fee >=1200 and tuition_fee <2500 THEN 'high'
                ELSE 'expensive'
                END) as 'price_rank',
                tuition_fee
FROM universities
JOIN cities on universities.city_id = cities.id
ORDER BY tuition_fee;              






DELIMITER $$

CREATE FUNCTION udf_average_alumni_grade_by_course_name(course_name VARCHAR(60))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	RETURN(SELECT AVG(students_courses.grade)
			FROM students_courses
            JOIN courses on courses.id = students_courses.course_id
            JOIN students on students.id = students_courses.student_id
            WHERE courses.name = course_name and is_graduated = 1);
END$$    
  
  
  
create PROCEDURE udp_graduate_all_students_by_year(year_started INT)
BEGIN
UPDATE students
JOIN students_courses ON students_courses.student_id = students.id
JOIN courses ON courses.id = students_courses.course_id
SET is_graduated = 1
WHERE year(courses.start_date)  = year_started;
END$$

