DELIMITER $$

CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT first_name, last_name
    FROM employees
    WHERE salary > 35000
    ORDER BY first_name, last_name, employee_id;
END$$



CREATE PROCEDURE usp_get_employees_salary_above(number_above DECIMAL(10,4))
 BEGIN
	SELECT first_name, last_name
    FROM employees
    WHERE salary >= `number_above`
    ORDER BY first_name, last_name, employee_id;
END$$    



CREATE PROCEDURE usp_get_towns_starting_with (start_str VARCHAR(30))
	BEGIN
		SELECT name
        FROM towns
        WHERE name like concat(start_str, '%')
        ORDER BY name;
    END$$    
    
    
    
    
CREATE PROCEDURE usp_get_employees_from_town(town_name_input VARCHAR(50))
		BEGIN
			SELECT first_name, last_name
            FROM employees
            JOIN addresses ON employees.address_id = addresses.address_id
            JOIN towns ON addresses.town_id = towns.town_id
            WHERE towns.name = town_name_input
            ORDER BY first_name, last_name, employee_id;
        END$$    
            

CREATE FUNCTION ufn_get_salary_level(employee_salary DECIMAL(10,2))
	RETURNS VARCHAR(10)
    DETERMINISTIC
    BEGIN
		RETURN(CASE
			WHEN employee_salary < 30000 THEN 'Low'
            WHEN employee_salary BETWEEN 30000 AND 50000 THEN 'Average'
            ELSE 'High'
            END);
    END$$  
    
    
    
    
CREATE PROCEDURE  usp_get_employees_by_salary_level(salary_level VARCHAR(10))
	BEGIN
		SELECT first_name, last_name
        FROM employees
        WHERE (SELECT ufn_get_salary_level(salar) = salary_level)
        ORDER BY first_name DESC, last_name DESC;
   END$$     
        


CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
	RETURNS BIT
    DETERMINISTIC
		RETURN word REGEXP (concat('^[', set_of_letters, ']+$'))$$
        
        
      
CREATE PROCEDURE usp_get_holders_full_name()
 BEGIN
	SELECT concat_ws(' ', first_name, last_name) as 'full_name'
    FROM account_holders
    ORDER BY `full_name`, id;
 END$$   
 
 
 
 CREATE PROCEDURE usp_get_holders_with_balance_higher_than (number_money DECIMAL(10,2))
  BEGIN
	SELECT first_name, last_name
    FROM account_holders 
    JOIN accounts ON accounts.account_holder_id = account_holders.id
    GROUP BY account_holder_id
    HAVING sum(accounts.balance)>number_money
    ORDER BY account_holders.id;
 END$$   
 
 
 
 
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(10,4), yearly_interest_rate DOUBLE,
number_of_years INT) 
	RETURNS DECIMAL(10,4)
    DETERMINISTIC
    BEGIN
	RETURN(sum*pow((1+yearly_interest_rate),number_of_years));
END$$    
  
  
  
  
  
CREATE PROCEDURE usp_calculate_future_value_for_account(id_account INT, interest_rate DECIMAL(20,4))  
	BEGIN
		SELECT a.id as 'account_id', first_name, last_name, balance as 'current balance', 
			(SELECT ufn_calculate_future_value(balance, interest_rate, 5))
        FROM account_holders as ah
        JOIN accounts as a ON a.account_holder_id = ah.id
        WHERE a.id = id_account;
  END$$  
  
  
  
  
 
 CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(20,4))
	BEGIN
		IF money_amount>0 THEN
        START TRANSACTION;
			UPDATE accounts
            SET balance = balance+ money_amount
            WHERE account_id = id;
            
            IF EXISTS(SELECT id FROM accounts WHERE account_id=id ) THEN COMMIT;
           ELSE
           ROLLBACK;
          END IF;
          END IF;
END$$
            
 