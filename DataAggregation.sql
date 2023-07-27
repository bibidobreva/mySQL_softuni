SELECT department_id, COUNT(id) as'Number of employees'
FROM employees
GROUP BY department_id;

SELECT department_id, ROUND(AVG(salary),2) as 'Average Salary'
FROM employees
GROUP BY department_id;


SELECT department_id,round( min(salary),2) as 'Min Salary'
FROM employees
GROUP BY department_id
HAVING `Min Salary` > 800;

SELECT count(*) as 'count'
FROM products
where category_id=2 and price>8;


SELECT	
		category_id,
        round(AVG(price),2) as 'Average Price',
        round(MIN(price),2) as 'Cheapest Price',
        round(MAX(price),2) as 'Most Expensive Price'
FROM products        
GROUP BY category_id;