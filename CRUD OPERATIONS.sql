SELECT id, first_name, last_name, job_title
 FROM employees
 ORDER BY id;
 
 
 SELECT id, 
 CONCAT(first_name,' ', last_name) AS 'full_name', 
 job_title, salary
 FROM employees
 WHERE salary>1000.00
 ORDER BY id;
 
 CREATE VIEW v_top_paid_employee AS
 SELECT *
 FROM employees
 ORDER BY salary DESC
 LIMIT 3;
 
 
 SELECT *
 FROM v_top_paid_employee;
 
 
 UPDATE employees 
SET salary=salary+100
 WHERE job_title ='Manager';
 
 SELECT salary
 FROM employees;


SELECT * 
FROM employees
ORDER BY salary DESC
LIMIT 1;


SELECT * FROM employees
WHERE department_id IN (4) 
AND salary >=1000
ORDER BY id;

 DELETE FROM employees
 WHERE department_id IN (2,1);
 SELECT * FROM employees;