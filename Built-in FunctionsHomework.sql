use soft_uni;

SELECT 
first_name, last_name
FROM employees
WHERE first_name LIKE 'Sa%'
ORDER BY employee_id;



SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;


SELECT first_name
FROM employees
WHERE department_id in(3, 10) 
AND YEAR(hire_date) BETWEEN 1995 AND 2005
ORDER BY employee_id;



SELECT first_name, last_name
FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;


SELECT name 
FROM towns
WHERE char_length(name) BETWEEN 5 AND 6
ORDER BY name;


SELECT town_id, name 
FROM towns
WHERE name REGEXP '^[MKBE]'
ORDER BY name;

SELECT town_id, name 
FROM towns
WHERE name NOT REGEXP '^[RBD]'
ORDER BY name;


CREATE VIEW `v_employees_hired_after_2000` AS
SELECT first_name, last_name
FROM employees
WHERE year(hire_date) >2000;



SELECT first_name, last_name
FROM employees
WHERE char_length(last_name)=5;





use geography;


SELECT country_name, iso_code
FROM countries
WHERE (char_length(country_name)-char_length(replace(lower(country_name),'a',''))) >=3
ORDER BY iso_code;


SELECT peak_name, river_name, lower(CONCAT(peak_name, SUBSTRING(river_name, 2))) as mix
FROM peaks, rivers
WHERE right(peak_name, 1) = left(river_name,1)
ORDER BY mix;



use diablo;

SELECT name, date_format(start,'%Y-%m-%d' ) as start
FROM games
WHERE YEAR(start) IN (2011,2012)
ORDER BY start, name
LIMIT 50;



SELECT
 user_name,  
 SUBSTR(`email`,LOCATE('@',`email`)+1) AS `email provider`
FROM users
ORDER BY `email provider`, user_name;
      



SELECT user_name, ip_address
FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name;


SELECT
   `name` AS game,
   CASE
   WHEN hour(start) BETWEEN 0 AND 11 THEN 'Morning'
   WHEN hour(start) BETWEEN 12 AND 17 THEN 'Afternoon'
   ELSE 'Evening'
   END AS 'DURATION',
   CASE
   WHEN duration <= 3 THEN 'Extra Short'
   WHEN duration BETWEEN 3 and 6 THEN 'Short'
   WHEN duration BETWEEN 6 and 10 THEN 'Long'
   ELSE 'Extra Long'
   END AS 'Duration'
FROM games;   


use orders;


SELECT
product_name,
order_date,
DATE_ADD(order_date, INTERVAL 3 DAY) AS 'pay_due',
DATE_ADD(order_date, INTERVAL 1 MONTH) AS 'deliver_due'
FROM orders;
