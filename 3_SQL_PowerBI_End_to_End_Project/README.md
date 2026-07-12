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

<img width="126" height="217" alt="image" src="https://github.com/user-attachments/assets/66cf3939-67f1-4cc8-adbb-1b3875f10ed4" />

### KPI over Time
This line and bar chart tracks riders, average profit, and average revenue 
on a monthly basis across 2021 and 2022. The chart shows a clear seasonal 
pattern where ridership and earnings peak around May to September and dip 
during the winter months.

<img width="653" height="287" alt="image" src="https://github.com/user-attachments/assets/64bca0bb-754c-42b6-84bf-337c63bfcfce" />

### Revenue by Season
This horizontal bar chart breaks down total revenue across the four seasons. 
Season 3 brings in the most revenue at 4.9M, followed by season 2 at 4.2M 
and season 4 at 3.9M. Season 1 is the weakest performer at 2.2M, which 
aligns with the seasonal trend seen in the KPI chart.

<img width="393" height="269" alt="image" src="https://github.com/user-attachments/assets/af71c378-132b-4d9c-821e-4b2a74cc338c" />

### Rider Demographic
This donut chart shows the split between registered and casual riders. 
81.17% of riders are registered users while casual riders make up the 
remaining 18.83%, telling us that the bike shop has a strong base of 
loyal recurring customers.
<img width="362" height="266" alt="image" src="https://github.com/user-attachments/assets/3e4e1e99-e3e5-4695-ae9f-355d0cddc863" />

### Revenue by Hour Table
The table breaks down revenue by hour across the days of the week, which goes through from day 0 (Sunday) to day 6 (Saturday). Sales 
start picking up around hour 8 and generally peak during midday between 
hours 10 and 14, with hour 11 standing out as one of the stronger 
performing hours across most days. Revenue gradually tapers off as the 
day moves toward the later evening hours.

<img width="343" height="285" alt="image" src="https://github.com/user-attachments/assets/987d5f1f-a3ee-48ae-bd73-29821fe80111" />


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

