-- End to end Project using SQL and Power BI
-- Data set: https://www.kaggle.com/datasets/walmalki/toman-bike-share-dataset
-- Columns: dteday, season, yr, mnth, hr, holiday, weekday, workingday, 
--          weathersit, temp, atemp, hum, windspeed, rider_type, riders

-- First we combine both years of bike share data into one result set
-- using a CTE so we have everything in one place before joining
with cte as (
SELECT dteday, season, yr, mnth, hr, holiday, weekday, workingday, weathersit, temp, atemp, hum, windspeed, rider_type, riders
FROM dbo.bike_share_yr_0
UNION ALL
SELECT dteday, season, yr, mnth, hr, holiday, weekday, workingday, weathersit, temp, atemp, hum, windspeed, rider_type, riders
FROM dbo.bike_share_yr_1)

-- Now we pull the columns we actually need and calculate revenue and profit
-- Revenue = riders * price
-- Profit = revenue minus the cost (COGS * price)
select 
dteday,
season,
a.yr,
weekday,
hr,
rider_type,
riders,
price,
COGS,
riders*price as revenue,
riders*price - COGS*price as profit

-- Join the cost table to bring in price and COGS for each year
from cte a
left join cost_table b
	on a.yr = b.yr;

-- The resulting data set from this query will be used in Power BI
-- to build the dashboard and visualizations
