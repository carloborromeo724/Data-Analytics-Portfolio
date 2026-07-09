# Layoffs 2022 Exploratory Data Analysis (SQL)

This is a follow up to my data cleaning project. Once I had a clean version of the Layoffs 2022 dataset, I wanted to actually dig into it and see what kind of trends or patterns show up, so this project is basically me exploring the cleaned table using SQL.

## Dataset

Same dataset as before, from Kaggle here: https://www.kaggle.com/datasets/swaptr/layoffs-2022

I worked off layoffs_staging2, which is the cleaned table from my earlier data cleaning project. Columns are company, location, industry, total_laid_off, percentage_laid_off, date, stage, and country.

## Why I did this

I didn't really start with a specific question in mind. The idea behind EDA is you just start poking around the data and see what jumps out, then once something interesting shows up you dig into it further. So this project starts really simple and gradually gets into more advanced queries as I started asking more specific questions.

## Tools

MySQL Workbench again. This time the focus was more on GROUP BY, aggregate functions, CTEs, and window functions like DENSE_RANK and SUM() OVER.

## What I did, step by step

**1. Just looking around first**

Before asking anything specific, I just selected everything from the clean table to get a feel for it again. Then I started with easy stuff like finding the single biggest layoff number in the whole dataset, and checking the percentage_laid_off column to see how big these layoffs actually were relative to each company's size.

One thing that stood out was looking at companies where percentage_laid_off was exactly 1, meaning the entire company got laid off. Turns out most of these were startups that shut down completely during this period. When I sorted those by funds raised, some pretty big names showed up, like BritishVolt (an EV company) and Quibi, which had raised close to 2 billion dollars before folding.

**2. Group by queries**

This is where I started comparing things against each other. I looked at:

Which single layoff event was the biggest (one company, one day).

Which companies had the highest total layoffs when added up across the whole dataset.

Totals broken down by location, country, industry, and company stage (like Series A or IPO).

Totals by year, just to see which year hit hardest.

**3. The harder queries**

This part took the longest to figure out. Instead of just looking at which companies had the most layoffs overall, I wanted to know which companies had the most layoffs each year specifically. I used a CTE to first get each company's total layoffs per year, then used DENSE_RANK() with PARTITION BY year on top of that to rank companies within each year and pull out the top 3.

I also wanted to see the trend build up over time instead of just isolated totals, so I did a rolling total of layoffs by month. First I grouped layoffs by month using SUBSTRING on the date, then wrapped that in a CTE so I could run SUM() OVER an ordered window on top of it to get an actual running total instead of just monthly numbers.

## What I found

A few things stood out to me:

Some companies laid off their entire workforce, mostly early stage startups, even after raising a ton of funding.

Layoffs weren't evenly spread across years, some years were clearly worse than others.

Certain industries and locations were hit way harder than others, which makes sense given how concentrated tech companies are in specific cities.

The rolling total really shows how layoffs picked up pace over time instead of staying flat.

## Things I learned

Starting an EDA with simple queries first really helps you build intuition before jumping into anything complex.

DENSE_RANK() combined with PARTITION BY is great for getting a top N per group, like top 3 companies per year in this case.

Wrapping a query in a CTE is a clean way to reuse an aggregated result if you need to run something like a window function on top of it.

Rolling totals give a much better sense of trend over time compared to just looking at raw monthly numbers.


