DROP TABLE IF EXISTS sales;
CREATE TABLE sales
(
            invoice_id INT,
            branch VARCHAR(15),
            city VARCHAR(30),
            category VARCHAR(30),
			unit_price float,
			quantity INT,
			date date,
			time time,
			payment_method VARCHAR(20),
			rating float,
			profit_margin float,
			total float
);
SELECT * FROM sales;

--1) Analyze payment method and sales
SELECT DISTINCT payment_method,
				count(*) AS total_transactions,
				sum(quantity) AS total_quantities
FROM sales
GROUP BY payment_method
ORDER BY 2;

--2a) Identify highest rated categories in each branch (Using DISTINCT ON)
SELECT DISTINCT ON (branch)
				branch,
				category,
				sum(rating) AS total_ratings
FROM sales
GROUP BY 1,2
ORDER BY 1,3 DESC;

--2b) Identify highest rated categories in each branch (Using windows func)
WITH RankedRating AS (
	SELECT DISTINCT branch,
				category,
				sum(rating) AS total_ratings,
				RANK() OVER (PARTITION BY branch ORDER BY sum(rating) DESC ) as rnk
				FROM sales
				GROUP BY 1,2)
SELECT branch, category, total_ratings
FROM RankedRating 
WHERE rnk =1
ORDER BY 1;

--3) Determie bussiest day in each branch
SELECT DISTINCT ON (branch)
				branch,
				date,
				count(*) AS total_transactions
FROM sales
GROUP BY 1,2
ORDER BY 1,3 DESC;
				
-- or
WITH rankday AS (
SELECT branch,
		date,
		count(*) AS total_transactions,
		ROW_NUMBER() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rnk
		FROM sales
		GROUP BY 1,2)
SELECT branch, date, total_transactions 
FROM rankday
WHERE rnk =1
ORDER BY 1;

--4) Total Quantities sold by payment method
SELECT payment_method,
		sum(quantity) AS total_quantity
FROM sales
GROUP BY 1
ORDER BY 2;

--5) Analyze category rating by City
SELECT city,
		category,
		SUM(rating) as total_rating
FROM sales
GROUP BY 1,2
ORDER BY 1 DESC;

--6) Calculate total profit by category
SELECT category,
		sum(unit_price*quantity*profit_margin) AS total_profit
FROM sales
GROUP BY 1
ORDER BY 2 DESC;

--7) Most common payment method per branch
SELECT DISTINCT ON (branch)
			branch,
			payment_method,
			count(*) AS total_transactions
FROM sales
GROUP BY 1,2
ORDER BY 1,3 DESC;

--8) Analyze sales shift throughout the day 
--   (i.e how many transactions occur in each morning,afternnon and evening shift)
SELECT 
	CASE
		WHEN time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
		WHEN time BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
		WHEN time BETWEEN '18:00:00' AND '23:59:59' THEN 'Evenong'
		ELSE 'Night' END AS shift,
		COUNT(*) AS total_transactions
FROM sales
GROUP BY 1
ORDER BY 2 DESC;

--9) Branch with highest revenue decline YoY.
WITH yearlyrevenue AS (
	SELECT
		branch,
		EXTRACT(YEAR FROM date) as sale_year,
		SUM(total) AS total_revenue
FROM sales
GROUP BY 1,2),
revenuecomparison AS (
	SELECT
		branch,
		sale_year,
		total_revenue,
		LAG(total_revenue) OVER(PARTITION BY branch ORDER BY sale_year) AS last_year_revenue
	FROM yearlyrevenue)
SELECT
	branch,
	sale_year,
	total_revenue,
	last_year_revenue,
	(total_revenue - last_year_revenue) AS revenue_change
FROM revenuecomparison
WHERE last_year_revenue IS NOT NULL
ORDER BY 5 DESC
LIMIT 1;

--10) Peak hour sale daywise
SELECT DISTINCT ON (day_of_week)
    TO_CHAR(date, 'Day') AS day_of_week,
    EXTRACT(HOUR FROM time) AS sale_hour,
    CONCAT(EXTRACT(HOUR FROM time), '-', EXTRACT(HOUR FROM time) + 1) AS hour_range,
    COUNT(*) AS total_transactions
FROM sales
GROUP BY 1, 2
ORDER BY day_of_week, total_transactions DESC;		
		

			
