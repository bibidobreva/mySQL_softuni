use gringotts;

SELECT count(*) as 'count'
FROM wizzard_deposits;


SELECT max(magic_wand_size) as 'longest_magic_wand'
FROM wizzard_deposits;


SELECT deposit_group, max(magic_wand_size) as 'longest_magic_wand'
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY `longest_magic_wand`, deposit_group;


SELECT deposit_group
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY avg(magic_wand_size)
LIMIT 1;


SELECT deposit_group, sum(deposit_amount) as 'total_sum'
FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY`total_sum`;


SELECT deposit_group, sum(deposit_amount) as 'total_sum'
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group;


SELECT deposit_group, sum(deposit_amount) as 'total_sum'
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING `total_sum` <150000
ORDER BY `total_sum` DESC;



SELECT deposit_group, magic_wand_creator,
min(deposit_charge) as 'min_deposit_charge'
FROM wizzard_deposits
GROUP BY deposit_group, magic_wand_creator
ORDER BY magic_wand_creator,deposit_group;


SELECT 
    (CASE
        WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
        WHEN age > 60 THEN '[61+]'
    END) AS 'age_group',
    COUNT(id)
FROM
    wizzard_deposits
GROUP BY `age_group`
ORDER BY `age_group`;


SELECT substr(first_name,1,1) as 'first_letter'
FROM wizzard_deposits
WHERE deposit_group = 'Troll Chest'
GROUP BY `first_letter`
ORDER BY `first_letter`;


SELECT deposit_group, is_deposit_expired,
		AVG(deposit_interest) as 'average_interest'
FROM wizzard_deposits
WHERE deposit_start_date >'1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired;



use soft_uni;


SELECT department_id, min(salary) as 'minimum_salary'
FROM employees
WHERE hire_date > 2000-01-01
GROUP BY department_id
HAVING department_id in (2,5,7)
ORDER BY department_id;






CREATE TABLE h_p_employee
SELECT *
FROM employees
WHERE salary >30000 AND manager_id  != 42;


UPDATE  h_p_employee
SET salary = salary +5000
WHERE department_id =1;



SELECT department_id, avg(salary) as 'avg_salary'
FROM h_p_employee
GROUP BY department_id
ORDER BY department_id;






SELECT department_id, max(salary) as 'max_salary'
FROM employees
GROUP BY department_id
HAVING `max_salary` not BETWEEN 30000 and 70000
ORDER BY department_id;


SELECT count(salary) as ''
FROM employees
GROUP BY manager_id
HAVING manager_id IS NULL;


SELECT e.department_id,
	(SELECT DISTINCT e1.salary
    FROM employees as e1
    WHERE e1.department_id = e.department_id
    ORDER BY e1.salary DESC
    LIMIT 1 OFFSET 2) AS 'third_highest_salary'
FROM employees as e
GROUP BY e.department_id
HAVING `third_highest_salary` IS NOT NULL
ORDER BY e.department_id;


SELECT e.first_name, e.last_name,  e.department_id
FROM employees as e
WHERE e.salary>(SELECT avg(e1.salary)
from employees as e1
WHERE e1.department_id=e.department_id)
ORDER BY department_id, employee_id
LIMIT 10;
        
        
        
SELECT department_id, sum(salary) as'total sum'
FROM employees
GROUP BY department_id
ORDER BY department_id;