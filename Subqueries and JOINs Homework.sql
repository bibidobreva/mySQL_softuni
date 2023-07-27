SELECT
	employee_id,
    job_title,
    employees.address_id,
    address_text
FROM employees
JOIN addresses ON addresses.address_id = employees.address_id
ORDER BY address_id
LIMIT 5;



SELECT first_name,
	last_name,
    towns.name as 'town',
    address_text
FROM employees    
JOIN addresses on addresses.address_id = employees.address_id
JOIN towns on addresses.town_id = towns.town_id
ORDER BY first_name, last_name
LIMIT 5;



SELECT employee_id,
	first_name,
    last_name,
    departments.name AS 'department_name'
 FROM employees 
 JOIN departments ON departments.department_id = employees.department_id
 WHERE name = 'Sales'
 ORDER BY employee_id DESC;
 
 
 
 SELECT employee_id,
	first_name,
    salary,
    departments.name AS 'department_name'
FROM employees
JOIN departments ON departments.department_id = employees.department_id
WHERE salary>15000
ORDER BY  departments.department_id DESC  
LIMIT 5;


SELECT employees.employee_id, first_name
FROM employees
LEFT JOIN employees_projects ON employees_projects.employee_id = employees.employee_id
WHERE employees_projects.project_id IS NULL
ORDER BY employee_id DESC
LIMIT 3;


SELECT first_name,
	last_name,
    hire_date,
    departments.name as 'dept_name'
FROM employees
JOIN departments ON departments.department_id = employees.department_id
WHERE  departments.name IN ('Sales', 'Finance') and hire_date > 1999-01-01
ORDER BY hire_date;    


SELECT employees.employee_id,
	first_name,
    projects.name AS 'project_name'
 FROM employees
  JOIN employees_projects ON employees_projects.employee_id =employees.employee_id
  JOIN projects ON employees_projects.project_id = projects.project_id
 WHERE 
	end_date IS NULL 
	AND DATE(start_date) > '2002-08-13' 
 ORDER BY employees.first_name, projects.name
 LIMIT 5;
 
 
 

 
 SELECT employees.employee_id,
	first_name,
    (CASE  
		WHEN YEAR(projects.start_date) >= 2005 THEN NULL 
		ELSE projects.name
        END) as 'project name' 
FROM employees
JOIN employees_projects ON employees_projects.employee_id =employees.employee_id 
JOIN projects ON employees_projects.project_id = projects.project_id 
WHERE employees.employee_id = 24 
ORDER BY projects.name;


SELECT e.employee_id,
	e.first_name,
    e.manager_id,
   ( SELECT first_name from employees as e1 WHERE e.manager_id = e1.employee_id) as'manager_name'
FROM employees as e
WHERE e.manager_id IN (3,7)
ORDER BY e.first_name;
    
    
    
SELECT e.employee_id,
	concat_ws(' ', e.first_name, e.last_name),
    (SELECT concat_ws(' ', e1.first_name, e1.last_name)
    FROM employees as e1 WHERE e.manager_id = e1.employee_id) as 'manager name',
    departments.name as 'department_name'
FROM employees as e
JOIN departments ON e.department_id = departments.department_id
WHERE e.manager_id IS NOT NULL
ORDER BY e.employee_id
LIMIT 5;



SELECT avg(salary) as 'min_average_salary'
FROM employees
JOIN departments on  employees.department_id = departments.department_id
GROUP BY departments.department_id
ORDER BY `min_average_salary`
LIMIT 1;





SELECT countries.country_code,
	mountain_range,
    peak_name,
    elevation
FROM peaks
JOIN mountains_countries ON peaks.mountain_id = mountains_countries.mountain_id
JOIN mountains ON mountains.id = peaks.mountain_id
JOIN countries ON countries.country_code = mountains_countries.country_code
WHERE countries.country_code = 'BG' and elevation > 2835
ORDER BY elevation DESC;


SELECT country_code,
	count(mountains.mountain_range) as 'mountain_range'
FROM mountains
JOIN mountains_countries ON mountains_countries.mountain_id = mountains.id
WHERE country_code IN ('BG', 'RU', 'US')
GROUP BY country_code
ORDER BY `mountain_range` DESC;


SELECT country_name,
	river_name
FROM  rivers
RIGHT JOIN countries_rivers ON rivers.id = countries_rivers.river_id
RIGHT JOIN countries ON countries_rivers.country_code = countries.country_code
WHERE continent_code = 'AF'
ORDER BY country_name
LIMIT 5;




