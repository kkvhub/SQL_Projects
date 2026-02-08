-- SQL Retail Sales Analysis
-- Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
					transactions_id	INT PRIMARY KEY,
					sale_date DATE,	
					sale_time TIME,
					customer_id	INT,
					gender VARCHAR(15),
					age INT,
					category VARCHAR(15),	
					quantity	INT,
					price_per_unit FLOAT,
					cogs FLOAT,
					total_sale FLOAT
                    );

SELECT * FROM retail_sales;

SELECT 
	COUNT(*) 
FROM retail_sales;

-- DATA CLEANING
-- CHECK NULL Values in the data set
SELECT * FROM retail_sales
WHERE 
	transactions_id IS null
	OR 
	sale_date IS null
	OR 
	sale_time IS null
	OR 
	customer_id IS null
	OR 
	gender IS null
	OR 
	age IS null
	OR 
	category IS null
	OR 
	quantity IS null
	OR 
	price_per_unit IS null
	OR 
	cogs IS null
	OR 
	total_sale IS null;

--DELETE the rows where there is missing values
DELETE FROM retail_sales
WHERE 
	transactions_id IS null
	OR 
	sale_date IS null
	OR 
	sale_time IS null
	OR 
	customer_id IS null
	OR 
	gender IS null
	OR 
	age IS null
	OR 
	category IS null
	OR 
	quantity IS null
	OR 
	price_per_unit IS null
	OR 
	cogs IS null
	OR 
	total_sale IS null;

-- DATA EXPLORATION

-- Number of sales in the data
SELECT COUNT(*) as total_sales FROM retail_sales;

-- Number of unique customer in the data
SELECT COUNT(DISTINCT customer_id ) as customer FROM retail_sales;

---- Number of unique categories in the data
SELECT DISTINCT category  as Categories FROM retail_sales;

-- DATA ANALYSIS AND FINDINGS
-- Retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05' ;

-- retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales
WHERE category = 'Clothing' 
	and sale_date >= '2022-11-01' 
	and sale_date < '2022-12-01'
	and quantity >= '4';
	
-- calculate the total sales (total_sale) for each category
SELECT category, 
	sum(total_sale) AS Total_Sales,
	count(*) as total_orders
FROM retail_sales
GROUP BY category;

-- Average age of customers who purchased items from the 'Beauty' category
SELECT category, 
	ROUND(AVG(age),2) AS Average_Age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;

--total number of transactions (transaction_id) made by each gender in each category
SELECT gender,category, 
	count(transactions_id) as total_transactions
FROM retail_sales
GROUP BY gender, category;

--top 5 customers based on the highest total sales
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;


--create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

-- End of Project






