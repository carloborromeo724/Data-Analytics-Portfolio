# End-to-End Data Project: SQL + Power BI
# Toman Bike Share Dashboard

## Overview
This project walks through the full process of taking raw bike share data, 
transforming it using SQL, and building an interactive dashboard in Power BI 
to analyze rider trends, revenue, and profitability for Toman Bike Shop 
across 2021 and 2022.

## Tools Used
- SQL (SQL Server)
- Power BI

## Dataset
- Source: https://www.kaggle.com/datasets/walmalki/toman-bike-share-dataset
- The dataset contains hourly bike share data across two years including 
  information on riders, weather conditions, seasons, and pricing.
- Columns: dteday, season, yr, mnth, hr, holiday, weekday, workingday, 
  weathersit, temp, atemp, hum, windspeed, rider_type, riders

## SQL Process

The first step before building the dashboard was to prepare the data 
in SQL Server. Here is what was done:

**1. Combined Two Years of Data**
The dataset was split across two separate tables, one for 2021 and 
one for 2022. A CTE was used along with UNION ALL to stack both tables 
into one combined result set, making it easier to work with everything 
in one place.

**2. Joined the Cost Table**
A LEFT JOIN was used to bring in the cost table which contained the 
price and COGS (Cost of Goods Sold) for each year. This was joined 
on the year column so that the correct pricing information was matched 
to each record.

**3. Calculated Revenue and Profit**
Using the riders and price columns, revenue was calculated by 
multiplying riders by price. Profit was then calculated by subtracting 
the cost from the revenue. These calculated columns were included 
directly in the SELECT statement.

**4. Passed the Data to Power BI**
The resulting dataset from the SQL query was connected directly to 
Power BI where it was used to build the dashboard and visualizations.

## Dashboard Overview
<img width="554" height="310" alt="image" src="https://github.com/user-attachments/assets/b2bdcb87-35d3-4563-b719-515a6b15c238" />

### Profit and Revenue Cards
The cards show the two headline numbers for the business. Total profit 
came in at 10.45M while total revenue reached 15M, giving an overall 
picture of how much the bike shop earned and how much it kept after costs.

<img width="62" height="113" alt="image" src="https://github.com/user-attachments/assets/659c960e-2292-472b-97f4-6f17bf280675" />

### KPI over Time
This line and bar chart tracks riders, average profit, and average revenue 
on a monthly basis across 2021 and 2022. The chart shows a clear seasonal 
pattern where ridership and earnings peak around May to September and dip 
during the winter months.

<img width="271" height="119" alt="image" src="https://github.com/user-attachments/assets/025ebeef-b166-4e47-ab11-e8def22426a4" />

### Revenue by Season
This horizontal bar chart breaks down total revenue across the four seasons. 
Season 3 brings in the most revenue at 4.9M, followed by season 2 at 4.2M 
and season 4 at 3.9M. Season 1 is the weakest performer at 2.2M, which 
aligns with the seasonal trend seen in the KPI chart.

<img width="164" height="113" alt="image" src="https://github.com/user-attachments/assets/0d969f93-b924-4c8f-9cec-68598e9346d4" />

### Rider Demographic
This donut chart shows the split between registered and casual riders. 
81.17% of riders are registered users while casual riders make up the 
remaining 18.83%, telling us that the bike shop has a strong base of 
loyal recurring customers.
<img width="155" height="111" alt="image" src="https://github.com/user-attachments/assets/852190bf-c065-4865-9ca9-5e81bb8feee5" />

### Revenue by Hour Table
The table breaks down revenue by hour across the days of the week, which goes through from day 0 (Sunday) to day 6 (Saturday). Sales 
start picking up around hour 8 and generally peak during midday between 
hours 10 and 14, with hour 11 standing out as one of the stronger 
performing hours across most days. Revenue gradually tapers off as the 
day moves toward the later evening hours.

<img width="140" height="119" alt="image" src="https://github.com/user-attachments/assets/0c4acdef-0b1b-4372-8814-d52cdc0a6046" />


### Profit Margin and Total Number of Riders
The profit margin sits at 0.45 or 45%, meaning nearly half of every dollar 
earned is kept as profit. The total number of riders across both years 
reached 3M, reflecting strong overall demand for the service.

<img width="201" height="44" alt="image" src="https://github.com/user-attachments/assets/85f24621-e555-40fc-8feb-29d87bb7fff4" />


## Key Findings
- Total revenue reached 15M with a profit margin of 45%
- Ridership and earnings consistently peak between May and September
- Season 3 is the most profitable season generating 4.9M in revenue
- The majority of riders at 81.17% are registered users
- Peak earning hours fall between 10 and 14, with hour 11 being 
  the strongest across most days of the week

## Files
- `SQL_end_to_end_project.sql` — SQL queries used to combine, transform, and 
  calculate revenue and profit
- `PowerBI_end_to_end_project.pbix` — Power BI dashboard file

