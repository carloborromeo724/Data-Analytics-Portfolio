# Data Analytics Portfolio

This portfolio is a collection of projects covering data cleaning, exploratory analysis, dashboard building, and predictive modeling. Each folder is a self-contained project with its own README going into more detail. This page is just meant to give a quick overview of what's in here and what each project demonstrates.

## Tools used across this portfolio
- **SQL** (MySQL Workbench, SQL Server) for cleaning, transforming, and querying data
- **Power BI** for building interactive dashboards
- **Python** (pandas, seaborn, matplotlib, scikit-learn, statsmodels) for exploratory analysis and predictive modeling

## Projects

### 1. [Layoffs 2022 Data Cleaning (SQL)](./1_Data_Cleaning_SQL)
Takes a messy real world dataset of global tech layoffs and cleans it from scratch in MySQL. Covers removing duplicates with `ROW_NUMBER()` and `PARTITION BY`, standardizing inconsistent text entries, converting a text based date column into an actual date type, filling in missing values using self joins, and dropping rows with no usable information. Ends with a clean and analysis-ready table.

**Skills demonstrated:** data cleaning, window functions, CTEs, self joins, string functions, data type conversion

### 2. [Layoffs 2022 Exploratory Data Analysis (SQL)](./2_Data_Exploration_SQL)
Builds on the cleaned dataset from Project 1 and digs into it to find patterns. Starts with simple lookups (biggest single layoff, companies that shut down entirely) and works up to more advanced queries, including ranking the top companies laid off per year using `DENSE_RANK()` with `PARTITION BY`, and calculating a rolling monthly total of layoffs using `SUM() OVER()`.

**Skills demonstrated:** GROUP BY and aggregate functions, CTEs, window functions, ranking, rolling totals

### 3. [Toman Bike Share Dashboard (SQL + Power BI)](./3_SQL_PowerBI_End_to_End_Project)
An end to end project that starts in SQL Server and ends in an interactive Power BI dashboard. Two years of hourly bike share data are combined with `UNION ALL`, joined against a cost table to calculate revenue and profit, then loaded into Power BI to visualize rider trends, seasonality, and profitability.

**Highlights from the dashboard:**
- Total revenue of 15M with a 45% profit margin
- Ridership and earnings consistently peak between May and September
- Season 3 is the strongest performer, bringing in 4.9M in revenue
- 81.17% of riders are registered users rather than casual riders
- Peak sales hours fall between 10am and 2pm

**Skills demonstrated:** SQL joins and CTEs, revenue and profit calculations, Power BI dashboard design, seasonal and hourly trend analysis

### 4. [E-commerce Customer Spending Prediction (Python, Linear Regression)](./4_Linear_Regression_Python)
Uses a multiple linear regression model to help an e-commerce company decide whether to focus more on their app or their website. Includes exploratory data analysis, a train/test split, model training with scikit learn, and a deeper statistical check using statsmodels to confirm which features actually matter.

**Key findings:**
- Length of membership and time spent on the app are the strongest and statistically significant drivers of yearly spend
- Time on the website has almost no effect (coefficient near zero) and isn't statistically significant (p = 0.377)
- The model explains about 98% of the variation in yearly spend on data it wasn't trained on (R squared of 0.981)

**Skills demonstrated:** exploratory data analysis, train/test splitting, linear regression with scikit learn, statistical inference with statsmodels, model evaluation (R squared, MAE, MSE, RMSE, residual analysis)

## How this repo is organized
Each numbered folder is a standalone project containing its own code and a project specific README with more detail, screenshots, and findings. This top level README is just an index to make it easy to jump into whichever project is relevant. 
