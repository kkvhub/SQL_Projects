
# 🛒 Retail Sales Analysis using SQL

## 📌 Project Overview
This project focuses on analyzing retail sales data using **SQL** to uncover meaningful business insights.  
The analysis includes **data cleaning, data exploration, and analytical queries** to understand customer behavior, sales performance, and operational patterns.

This project demonstrates practical SQL skills commonly required for **Data Analyst** and **Business Analyst** roles.

---

## 🗂️ Dataset Description
The dataset contains transactional-level retail sales data with the following attributes:

- **transactions_id** – Unique transaction identifier  
- **sale_date** – Date of transaction  
- **sale_time** – Time of transaction  
- **customer_id** – Unique customer identifier  
- **gender** – Gender of customer  
- **age** – Age of customer  
- **category** – Product category  
- **quantity** – Quantity sold  
- **price_per_unit** – Price per unit  
- **cogs** – Cost of goods sold  
- **total_sale** – Total sales value  

---

## 🛠️ Tools & Technologies
- SQL  
- Relational Database (PostgreSQL / MySQL compatible syntax)  
- GitHub for version control  

---

## 🔄 Project Workflow

### 1️⃣ Database & Table Creation
- Created a structured `retail_sales` table  
- Defined appropriate data types  
- Applied primary key constraints  

### 2️⃣ Data Cleaning
- Identified missing (NULL) values  
- Removed incomplete records to maintain data integrity  

### 3️⃣ Data Exploration
- Total number of sales  
- Unique customer count  
- Distinct product categories  

### 4️⃣ Data Analysis & Business Insights
- Daily sales analysis for a specific date  
- Category-wise sales performance  
- Monthly filtering with quantity conditions  
- Average customer age by product category  
- Gender-based transaction distribution  
- Top 5 customers by total revenue  
- Shift-wise sales analysis (Morning, Afternoon, Evening)  

---

## 📊 Sample SQL Queries

### Total Sales by Category
```sql
SELECT category, 
       SUM(total_sale) AS total_sales,
       COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

### Top 5 Customers by Revenue
```sql
SELECT customer_id,
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### Shift-wise Order Analysis
```sql
WITH hourly_sale AS (
    SELECT *,
           CASE
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM retail_sales
)
SELECT shift,
       COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

---

## 📈 Key Insights
- Identification of **high-performing product categories**  
- Understanding **customer demographics** by category  
- Recognition of **top revenue-generating customers**  
- Analysis of **peak sales periods during the day**  

---

## 🚀 How to Run This Project
1. Create a database in your SQL environment  
2. Run the table creation script  
3. Insert the retail sales data  
4. Execute the analysis queries  

---

## 📌 Conclusion  
This project highlights the use of SQL for end-to-end retail sales analysis, from data cleaning to insight generation. The results provide valuable visibility into customer behavior, sales trends, and operational patterns, reinforcing the importance of SQL as a core tool for data and business analytics.
---

## 👤 Author
**Kaushlendra Kumar Verma**  
MS in Business Analytics  
Aspiring Data / Business Analyst
www.linkedin.com/in/kaushlendra-kumar-verma  

📫 *Feel free to explore more projects on my GitHub profile!*
