USE gamebar;
CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL
);

CREATE TABLE categories(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);

CREATE TABLE products(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
category_id INT NOT NULL
);

INSERT  employees (first_name, last_name)
VALUES
('Test1', 'Test1'),
('Test2', 'Test2'),
('Test2', 'Test2');

ALTER TABLE employees
ADD COLUMN middle_name VARCHAR(50);


ALTER TABLE products
ADD CONSTRAINT fk_products_categories
  FOREIGN KEY (category_id)
  REFERENCES categories(id);
  
  ALTER TABLE employees
  MODIFY middle_name VARCHAR(100);
  
