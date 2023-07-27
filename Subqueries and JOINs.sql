SELECT employee_id, 
concat_ws(' ', first_name, last_name) as 'full_name', 
departments.department_id, 
departments.name AS 'department_name'
FROM departments
JOIN employees ON departments.manager_id = employees.employee_id
ORDER BY employee_id
LIMIT 5;




SELECT towns.town_id, `name` as 'town_name', address_text
FROM towns
JOIN addresses ON towns.town_id = addresses.town_id
WHERE `name` IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY town_id, address_id;




SELECT employee_id,
	first_name,
    last_name,
    department_id,
    salary
FROM employees
WHERE manager_id IS NULL;    

SELECT count(e.employee_id) as 'count'
from employees as e
where salary >(SELECT avg(e1.salary)
from employees as e1);