# 📊 Walmart Sales Data Analytics Project

**End-to-End Data Engineering + SQL + Power BI Dashboard**

------------------------------------------------------------------------

## 📌 Project Overview

This project analyzes Walmart sales data using a complete data analytics
pipeline:

**Kaggle API → Python (ETL & Cleaning) → PostgreSQL (SQL Analysis) →
Power BI (Visualization & Insights)**

The objective is to extract meaningful business insights from
transactional sales data and present them through an executive-level
interactive dashboard.

------------------------------------------------------------------------

## 🏗️ Project Architecture

![Architecture Diagram](project_architecture.png)

------------------------------------------------------------------------

## 🗂️ Dataset

-   Source: Kaggle -- Walmart Sales Dataset\
-   Format: CSV\
-   Fields include:
    -   Invoice ID
    -   Branch
    -   City
    -   Category
    -   Unit Price
    -   Quantity
    -   Date & Time
    -   Payment Method
    -   Rating
    -   Profit Margin
    -   Total Sales

------------------------------------------------------------------------

## ⚙️ Data Pipeline

### 1️⃣ Data Extraction & Cleaning (Python)

-   Extracted dataset using Kaggle API
-   Cleaned and formatted data
-   Handled missing values
-   Corrected data types
-   Exported cleaned CSV

### 2️⃣ Database & SQL Analytics (PostgreSQL)

-   Created structured sales table
-   Used advanced SQL queries:
    -   CTEs
    -   Window functions (RANK, ROW_NUMBER, LAG)
    -   Aggregations
    -   Date & time extraction

### 3️⃣ Power BI Dashboard

Dashboard includes: - Executive revenue overview - Profit by category -
Payment method analysis - Busiest day per branch - Sales shift
analysis - Year-over-year revenue comparison

------------------------------------------------------------------------

## 📊 Key Business Insights

-   Electronics category generates highest profit contribution.
-   Afternoon shift drives maximum transactions.
-   Digital payments dominate in specific branches.
-   Some branches show revenue decline year-over-year.
-   Weekend traffic increases transaction volume significantly.

------------------------------------------------------------------------

## 🧠 Business Recommendations

1.  Optimize staffing based on peak sales hours.
2.  Promote high-margin product categories.
3.  Encourage digital payment incentives.

------------------------------------------------------------------------

## 🛠️ Tools & Technologies

-   Python (Pandas, Kaggle API)
-   PostgreSQL
-   Advanced SQL
-   Power BI
-   Git & GitHub

------------------------------------------------------------------------

## 📂 Repository Structure

    Walmart-Sales-Analytics/
    │
    ├── data/
    ├── notebooks/
    ├── sql/
    ├── powerbi/
    ├── project_architecture.png
    └── README.md

------------------------------------------------------------------------

## 👤 Author

Kaushlendra Kumar Verma\
MS Business Analytics\
Data Analytics \| SQL \| Power BI \| Python \
www.linkedin.com/in/kaushlendra-kumar-verma  
