# 🎵 Spotify Data Analysis using SQL

## 📌 Project Overview

This project analyzes Spotify music data sourced from Kaggle using **SQL
for data exploration and analytical queries**.

The goal of this project is to: - Perform structured data cleaning\
- Conduct exploratory data analysis (EDA)\
- Apply advanced SQL concepts (Window Functions, CTEs, Aggregations,
Filtering)\
- Extract actionable music insights\
- Prepare dataset for visualization in Tableau

------------------------------------------------------------------------

## 📂 Dataset Information

**Source:** Kaggle\
🔗 https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset

The dataset includes: - Artist and Track Information\
- Album Details\
- Audio Features (danceability, energy, loudness, etc.)\
- Engagement Metrics (views, likes, comments, streams)\
- Platform Distribution (Spotify vs YouTube)\
- Licensing and Official Video flags

------------------------------------------------------------------------

## 🗂️ Database Schema

Table Name: `spotify`

Key columns include: - artist\
- track\
- album\
- album_type\
- danceability\
- energy\
- loudness\
- speechiness\
- acousticness\
- instrumentalness\
- liveness\
- valence\
- tempo\
- duration_min\
- views\
- likes\
- comments\
- stream\
- most_played_on

------------------------------------------------------------------------

## 🛠️ SQL Concepts Used

-   Table creation & data cleaning\
-   Aggregate Functions (SUM, AVG, COUNT)\
-   GROUP BY & ORDER BY\
-   DISTINCT\
-   Window Functions (DENSE_RANK, SUM OVER)\
-   CTE (Common Table Expressions)\
-   FILTER clause\
-   Subqueries

------------------------------------------------------------------------

## 🔎 Exploratory Data Analysis

### Data Cleaning

-   Removed tracks with zero duration\
-   Checked for zero views\
-   Verified distinct artist counts

------------------------------------------------------------------------

## 📊 Key Analytical Insights

✔ Identified billion-stream tracks\
✔ Analyzed engagement metrics for licensed & official videos\
✔ Ranked top 3 tracks per artist using window functions\
✔ Compared Spotify vs YouTube streaming dominance\
✔ Calculated album-level energy spread using CTE\
✔ Evaluated energy-to-liveness ratio\
✔ Computed cumulative likes trend

------------------------------------------------------------------------

## 📈 Business Insights

-   Identify high-performing artists and tracks\
-   Understand audio feature impact on popularity\
-   Platform-specific engagement comparison\
-   Support recommendation system improvements

------------------------------------------------------------------------

## 📊 Tableau Dashboard (Next Phase)

This SQL project serves as the backend foundation for an interactive
Tableau dashboard to visualize:

-   Top Artists & Tracks\
-   Engagement Distribution\
-   Audio Feature Correlations\
-   Platform Comparison\
-   Popularity Trends

🔗 **Tableau Profile:**\
👉 ----

------------------------------------------------------------------------

## 🚀 Future Enhancements

-   Correlation analysis between engagement & audio features\
-   Genre segmentation\
-   Time-series streaming analysis\
-   Clustering using audio attributes\
-   Basic recommendation modeling

------------------------------------------------------------------------

## 💻 Tools & Technologies

-   SQL (PostgreSQL)\
-   Kaggle Dataset\
-   Tableau\
-   Git & GitHub

------------------------------------------------------------------------

## 👤 Author

**Kaushlendra**\
MS in Business Analytics\
Highway Design Engineer → Data Analytics Transition
www.linkedin.com/in/kaushlendra-kumar-verma  
