🛒 SQL Sales Project Analysis
📘 Overview

This project demonstrates how to perform data cleaning, exploration, and analysis on a retail shop’s sales data using SQL.
It simulates a real-world scenario where transaction data is analyzed to derive key business insights such as customer behavior, sales trends, and category performance.

🧱 Database Structure

Database: sql_sales_project
Table: shop_sales

'''sql
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
'''       


🧹 Data Cleaning

The script removes records containing NULL values across key fields to ensure the dataset is clean and ready for analysis:

'''sql

DELETE FROM shop_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
'''

🔍 Data Exploration

Basic exploratory queries include:

Total sales amount

Number of unique customers

Distinct product categories

'''sql

SELECT SUM(total_sale) AS total_sales_amount FROM shop_sales;

SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM shop_sales;

SELECT DISTINCT category FROM shop_sales;
'''

📊 Analysis Queries
1️⃣ Sales on a Specific Date

Retrieve all sales made on a given date:

'''sql

SELECT * FROM shop_sales WHERE sale_date = '2023-05-12';
'''

2️⃣ Category Sales in a Specific Month
'''sql

SELECT * FROM shop_sales
WHERE category = 'Electronics'
  AND sale_date BETWEEN '2023-05-01' AND '2023-05-31'
  AND quantity >= 4;
'''

3️⃣ Total Sales per Category
'''sql

SELECT category, SUM(total_sale) AS total_sale_amount, COUNT(*) AS total_orders
FROM shop_sales
GROUP BY category;
'''
4️⃣ Average Age of Customers in a Category
'''sql

SELECT ROUND(AVG(age), 2) AS avg_age
FROM shop_sales
WHERE category = 'Clothing';
'''
5️⃣ High-Value Female Customers
'''sql

SELECT * FROM shop_sales
WHERE total_sale >= 2000 AND gender = 'Female' AND age >= 41;
'''
6️⃣ Transactions by Gender and Category
'''sql

SELECT category, gender, COUNT(*) AS total_transactions
FROM shop_sales
GROUP BY category, gender
ORDER BY category;
'''
7️⃣ Top 5 Customers by Total Sales
'''sql

SELECT customer_id, SUM(total_sale) AS total_sales
FROM shop_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
'''
8️⃣ Unique Customers by Category
'''sql

SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM shop_sales
GROUP BY category;
'''
9️⃣ Orders by Time of Day (Shift Analysis)
'''sql

WITH hourly_sale AS (
  SELECT *,
    CASE
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM shop_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
'''
🔟 Top 5 Customers by Quantity Purchased
'''sql

SELECT customer_id, SUM(quantity) AS total_quantity
FROM shop_sales
GROUP BY customer_id
ORDER BY total_quantity DESC
LIMIT 5;
'''
📈 Key Insights (Example)

Most sales occur in the Afternoon shift.

Clothing and Electronics are top-performing categories.

Repeat customers contribute significantly to total revenue.

High-value customers (spending ≥2000) are typically aged 40+.

🧰 Tools Used

SQL (PostgreSQL/MySQL) for querying and analysis.



📎 How to Use

Download or clone this repository:

git clone https://github.com/chandrasekharpanda304/sql-sales-project-analysis.git


Open the SQL file in your preferred SQL editor.

Run the script step by step to create the database, clean data, and execute analytical queries.

📜 Author

Your Name
📧 [your.email@example.com
]
💼 [LinkedIn Profile or Portfolio link]
