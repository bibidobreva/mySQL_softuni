DELIMITER $$
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN(
SELECT count(*)
FROM employees AS e
	JOIN addresses AS a ON e.address_id = a.address_id
	JOIN towns AS t ON a.town_id =t.town_id 
WHERE t.name =town_name);
END$$

DELIMITER ;
SELECT ufn_count_employees_by_town('Sofia') as count;








DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
 UPDATE  employees
 JOIN departments ON departments.name = employees.department_id
 SET salary = salary*1.05
 WHERE departments.name = department_name;
 END$$
 
 DELIMITER ;
 
 CALL usp_raise_salaries('Finance');
 
 
 
 
 
 
 
 
 DELIMITER $$
 
 CREATE PROCEDURE usp_raise_salary_by_id(id INT)
 BEGIN 
 START TRANSACTION;
	IF((SELECT count(employee_id) FROM employees WHERE employee_id Like id)<>1)
    THEN ROLLBACK;
    ELSE
  UPDATE employees
  SET salary = salary +salary*0.05
  WHERE employee_id = id;
  END IF;
END$$

DELIMITER ;
CALL usp_raise_salary_by_id();
 
 
 
 
 
 
 
 
 
 
 CREATE TABLE IF NOT EXISTS deleted_employees(
 employee_id INT AUTO_INCREMENT PRIMARY KEY,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 middle_name VARCHAR(50) NOT NULL,
 job_title VARCHAR(50) NOT NULL,
 department_id int NOT NULL,
 salary DECIMAL(19,4)
 );
 
 
 DELIMITER $$
CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees(first_name,last_name,middle_name,job_title,department_id,salary)
    VALUES (OLD.first_name,OLD.last_name,OLD.middle_name,OLD.job_title,OLD.department_id,OLD .salary);
END $$    

