CREATE DATABASE restaurantExam;

CREATE TABLE products(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL UNIQUE,
type VARCHAR(30) NOT NULL,
price DECIMAL(10, 2) NOT NULL);


CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    card VARCHAR(50),
    review TEXT
);


CREATE TABLE `tables`(
id INT AUTO_INCREMENT PRIMARY KEY,
floor INT NOT NULL,
reserved BOOLEAN,
capacity INT NOT NULL
);


CREATE TABLE waiters(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
phone VARCHAR(50),
salary DECIMAL(10,2)
);



CREATE TABLE orders(
id INT AUTO_INCREMENT PRIMARY KEY,
table_id INT NOT NULL,
waiter_id INT NOT NULL,
order_time TIME NOT NULL,
payed_status BOOLEAN,
CONSTRAINT fk_table_id_tables_orders 
FOREIGN KEY (table_id)
REFERENCES `tables`(id),
CONSTRAINT fk_waiter_id_waiters_orders
FOREIGN KEY (waiter_id)
REFERENCES waiters(id)
);


CREATE TABLE orders_clients(
order_id INT NOT NULL,
client_id INT NOT NULL,
CONSTRAINT fk_order
FOREIGN KEY (order_id)
REFERENCES orders(id),
CONSTRAINT fk_client
FOREIGN KEY (client_id)
REFERENCES clients(id)
);


CREATE TABLE orders_products(
order_id INT NOT NULL,
product_id INT NOT NULL,
CONSTRAINT fk_order_id
FOREIGN KEY (order_id)
REFERENCES orders(id),
CONSTRAINT fk_product_id
FOREIGN KEY (product_id)
REFERENCES products(id)
);








INSERT INTO  products(name, type, price)
SELECT concat_ws(' ',last_name, 'specialty'), 'Cocktail', format(ceil(salary*0.01),2)
FROM waiters
WHERE id>6;



UPDATE orders
SET table_id = table_id-1
WHERE id BETWEEN 12 and 23;





DELETE waiters FROM waiters
LEFT JOIN orders ON orders.waiter_id = waiters.id
WHERE waiter_id IS NULL;









SELECT id, first_name, last_name, birthdate, card, review
FROM clients 
ORDER BY birthdate DESC, id DESC;


SELECT first_name,
last_name ,
birthdate,
review
FROM clients
WHERE card IS NULL
AND YEAR(birthdate) BETWEEN 1978 AND 1993
ORDER BY last_name DESC, id
LIMIT 5;


SELECT concat(last_name, first_name, CHARACTER_LENGTH(first_name), 'Restaurant') as 'username',
	 reverse(substr(email,2,12)) as `password`
FROM waiters  
WHERE salary IS NOT NULL
ORDER BY `password` DESC; 




SELECT id, name,
	count(order_id) as `count`
FROM products  
JOIN orders_products ON products.id = orders_products.product_id
GROUP BY product_id
HAVING  `count` >= 5
ORDER BY `count` DESC, name;





SELECT tables.id as 'table_id', capacity,
	count(client_id) as 'count_clients',
   ( CASE
			WHEN capacity > count(client_id) THEN 'Free seats'
            WHEN capacity = count(client_id) THEN 'Full'
            ELSE 'Extra seats'
     END       
    ) as 'availability'
   FROM `tables`
   JOIN orders ON orders.table_id = tables.id
   JOIN orders_clients ON orders_clients.order_id = orders.id
    WHERE floor = 1
   GROUP BY tables.id
   ORDER BY tables.id DESC;
   
   
   
   
   
   
	
    DELIMITER $$
    
    
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50)) 
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN 

DECLARE f_name VARCHAR(50);
DECLARE l_name VARCHAR(50);
DECLARE space INT;

SET space := locate(' ', full_name);
SET f_name := substr(full_name, 1, space-1);
SET l_name := substr(full_name, space+1);

RETURN( SELECT sum(price) 
			FROM clients
            JOIN orders_clients ON clients.id = orders_clients.client_id
            JOIN orders_products ON orders_products.order_id = orders_clients.order_id
            JOIN products ON orders_products.product_id = products.id
            WHERE clients.first_name = f_name AND clients.last_name = l_name);
            END$$
            
            
            
            
            
            
            
            
            
            
            
            
            
            
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50)) 
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN 
RETURN( SELECT sum(price) 
			FROM clients
            JOIN orders_clients ON clients.id = orders_clients.client_id
            JOIN orders_products ON orders_products.order_id = orders_clients.order_id
            JOIN products ON orders_products.product_id = products.id
            WHERE concat_ws(' ', clients.first_name, clients.last_name) = full_name);
            END$$
            
            
            
            
            
CREATE PROCEDURE udp_happy_hour (type_p VARCHAR(50))
BEGIN 
	UPDATE  products
    SET price = price-price*0.2
    WHERE price >= 10.00 AND type = type_p;
    END$$
	
	