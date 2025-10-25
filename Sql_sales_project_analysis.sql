-- SQL Shop Sales Analysis
CREATE DATABASE sql_sales_project;


-- Create TABLE
DROP TABLE IF EXISTS shop_sales;
CREATE TABLE shop_sales
          (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(20),
                age	INT,
                category VARCHAR(20),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
                                       );

SELECT * FROM shop_sales


-- Data Cleaning


SELECT * FROM shop_sales 
    WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
	OR
	age IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- data Ddeleyion of null values--

DELETE FROM shop_sales
    WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
	OR
	age IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- what is the total sales amount we have?

SELECT SUM (total_sale) as total_sale_amount FROM shop_sales

-- How many uniuque customers we have?

SELECT COUNT(DISTINCT customer_id) as unique_customer FROM shop_sales

-- how many categories we have?

SELECT DISTINCT category FROM shop_sales


-- Data Analysis 

-- Q&A

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2023-05-12'

SELECT *
FROM shop_sales
WHERE sale_date = '2023-05-12'


-- Q.2 Write a SQL query to find all transactions where the category is 'Electronics'
--and the quantity sold is more than equal to 4 in the month of may-2023

SELECT * 
FROM shop_sales
WHERE 
    category = 'Electronics'
    AND sale_date >= '2023-05-01'
    AND sale_date < '2023-06-01'
    AND quantity >= 4;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    category,
    SUM(total_sale) as total_sale_amount,
    COUNT(*) as total_orders
FROM shop_sales
GROUP BY category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Clothing' category.

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM shop_sales
WHERE category = 'Clothing'


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than or equal to 2000 and gender is female.

SELECT * FROM shop_sales
WHERE total_sale >= 2000
AND gender = 'Female'
AND age >= 41


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM shop_sales
GROUP BY 
    category,
    gender
ORDER BY category


-- Q.7 Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM shop_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

-- Q.8 Write a SQL query to find the number of unique customers who purchased items from each category.


SELECT 
    category,    
    COUNT(DISTINCT customer_id) as unique_cs
FROM shop_sales
GROUP BY category



-- Q.9 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM shop_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

-- Q.10 Write a sql query to find out the top 5 customer who ordered most quantity.

SELECT 
    customer_id, 
    SUM(quantity) AS total_quantity,
FROM shop_sales
GROUP BY customer_id,
ORDER BY total_quantity DESC
LIMIT 5;


-- End of project