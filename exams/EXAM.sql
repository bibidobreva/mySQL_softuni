create database electronic_devices;


CREATE table brands(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(40) NOT null UNIQUE
);

create table categories(
id int primary key auto_increment,
name VARCHAR(40) NOT null UNIQUE
);


create table reviews(
id int PRIMARY KEY AUTO_INCREMENT,
content TEXT,
rating DECIMAL(10,2) NOT NULL,
picture_url VARCHAR(80) not null,
published_at datetime not null
);



create table products(
id int primary key AUTO_INCREMENT,
name VARCHAR(40) not null,
price DECIMAL(19,2) NOT NULL,
quantity_in_stock int,
description TEXT,
brand_id INT,
category_id INT,
review_id INT,
CONSTRAINT fk_brand_products_id
FOREIGN KEY (brand_id)
REFERENCES brands(id),
CONSTRAINT fk_category_id_products_id
FOREIGN KEY (category_id)
REFERENCES categories(id),
CONSTRAINT fk_review_id__products_id
FOREIGN KEY (review_id)
REFERENCES reviews(id)
);



create table customers (
id int primary key AUTO_INCREMENT,
first_name VARCHAR(20) not null,
last_name VARCHAR(20) not null,
phone VARCHAR(30) not null UNIQUE,
address VARCHAR(60) not null,
discount_card BIT DEFAULT FALSE
);


create table orders(
id int PRIMARY key AUTO_INCREMENT,
order_datetime DATETIME not null,
customer_id INT not null,
CONSTRAINT fk_customers_id_orders
FOREIGN KEY (customer_id)
REFERENCES customers(id)
);

create table orders_products(
order_id int not null,
product_id int not null,
CONSTRAINT fk_order_id__orders_products
FOREIGN KEY (order_id)
REFERENCES orders(id),
CONSTRAINT fk_product_id__orders_products
FOREIGN KEY (product_id)
REFERENCES products(id)
);







INSERT INTO reviews (content, picture_url, published_at, rating)
SELECT substr(description, 1,15),
	reverse(name),
    '2010-10-10',
    price/8
 FROM products
 WHERE id >=5;
 
 
 
UPDATE products
SET  quantity_in_stock = quantity_in_stock -5
WHERE quantity_in_stock BETWEEN 60 and 70;


DELETE customers from customers
LEFT JOIN orders ON orders.customer_id = customers.id
WHERE orders.id IS NULL;






SELECT id, name FROM categories
ORDER BY name DESC;


SELECT id, brand_id, name, quantity_in_stock
FROM products
WHERE price >1000 and quantity_in_stock <30
ORDER BY quantity_in_stock, id;



SELECT * 
FROM reviews
WHERE content LIKE 'My%' 
	AND char_length(content) >61
ORDER BY rating DESC; 



SELECT concat_ws(' ', first_name, last_name) as 'full_name',
	address,
    order_datetime as 'order_date'
FROM customers    
JOIN orders ON   customers.id = orders.customer_id
WHERE year(order_datetime) <= '2018'
ORDER BY `full_name` DESC;


SELECT count(products.id) as 'items_count', 
	categories.name, 
    sum(products.quantity_in_stock) as 'total_quantity'
FROM categories
JOIN products on products.category_id = categories.id
GROUP BY category_id
ORDER BY `items_count` DESC, `total_quantity`
LIMIT 5;    





DELIMITER $$

create FUNCTION udf_customer_products_count(name VARCHAR(30))
RETURNS INT 
DETERMINISTIC
BEGIN
RETURN(
	SELECT count(products.id)
    FROM products
    JOIN orders_products ON orders_products.product_id = products.id
    JOIN orders ON orders.id = orders_products.order_id
    JOIN customers ON customers.id = orders.customer_id
	WHERE first_name = name

);
END$$




CREATE PROCEDURE udp_reduce_price (category_name VARCHAR(50))
BEGIN
UPDATE products
JOIN categories ON categories.id = products.category_id
JOIN  reviews ON reviews.id = products.review_id
SET price = price*0.70
WHERE rating <4 AND categories.name = category_name;
END $$
