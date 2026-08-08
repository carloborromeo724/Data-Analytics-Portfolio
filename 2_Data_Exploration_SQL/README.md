# Data Exploration with SQL
# Layoffs 2022 — Exploratory Data Analysis

## Overview
This project is a follow up to the Data Cleaning project done on
the same Layoffs 2022 dataset. Now that the data has been cleaned
and standardized, this project focuses on exploring it using SQL
to uncover trends and patterns in tech industry layoffs. Starting
with simple queries to get a feel for the data, then progressively
moving into more complex aggregations and window functions to answer
specific questions about which companies, industries, and countries
were hit the hardest.

## Tools Used
- SQL (MySQL)

## Dataset
- Source: https://www.kaggle.com/datasets/swaptr/layoffs-2022
- Table used: layoffs_staging2 (the cleaned version from the data cleaning script)
- Columns: company, location, industry, total_laid_off,
  percentage_laid_off, date, stage, country

## Steps

**1. Initial Exploration**
Started by looking at the full dataset with no specific question
in mind, just poking around to see what stands out and get ideas
for what to dig into further.

**2. Easy Queries First**
Looked at the biggest single layoff event and checked the
percentage_laid_off column to understand how severe each layoff
was relative to each company's total workforce.

**3. Companies That Completely Shut Down**
Filtered for companies where percentage_laid_off = 1, meaning
the entire workforce was laid off. Then sorted by funds raised
to see how large some of these companies were before folding.

**4. Group By Queries**
Aggregated total layoffs by company, location, country, year,
industry, and company stage to compare which groups were
affected the most across the full dataset.

**5. Ranking Companies Per Year**
Used CTEs and DENSE_RANK window function to find the top 3
companies with the most layoffs for each year, showing how
the biggest names shifted from year to year.

**6. Rolling Total Over Time**
Used a CTE combined with a SUM window function to calculate
a running total of layoffs month by month, showing how
cumulative layoffs built up from March 2020 to March 2023.

## Key Findings

**Big Tech Dominated the Numbers**
When you look at the top layoff events, it is mostly the same
names showing up over and over. Google, Meta, and Amazon are
at the top whether you are looking at single day events or
total layoffs across the whole period. The scale of these
companies means that even one round of cuts from them can
move the overall numbers significantly.

**A Lot of Startups Simply Closed**
116 companies had a percentage_laid_off of 1, meaning they
did not just downsize, they shut down completely. Some of
these were not small operations either. Quibi had raised
close to 2 billion dollars before calling it quits. Clearly
having a lot of funding does not always mean you make it.

**The US and the Bay Area Took the Biggest Hit**
The United States had 256,559 layoffs, way ahead of every
other country. Drilling down into locations, the SF Bay Area
alone accounted for 125,631 of those. Not exactly shocking
given how much of the tech industry is concentrated there,
but the numbers are still pretty staggering.

**2022 Was the Worst Year**
2022 had the most layoffs at 160,661, with 2023 not far
behind at 125,677. Compare that to 2021 which only had
15,823 and it is clear something shifted. A lot of companies
over-hired during the pandemic boom and by 2022 they were
pulling back hard.

**Consumer and Retail Were Hit Hard**
Consumer led all industries with 45,182 layoffs and Retail
came in second at 43,613. Tech companies tend to get most
of the attention in layoff news but the data shows the
impact spread well beyond pure software companies into
more consumer facing businesses as well.

**Layoffs Grew Steadily Over Time**
The running total started at 10,128 in March 2020 and
reached 383,659 by March 2023. It was not a sudden spike,
it just kept building month after month over three years,
which tells a different story than the idea of layoffs
being a short term reaction to one specific event.

## Files
- `DataExplorationSQL.sql` — SQL queries used for exploration

