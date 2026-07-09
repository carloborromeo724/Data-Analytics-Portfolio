# Layoffs 2022 Data Cleaning Project (SQL)

This is a personal project I did to practice my SQL skills, specifically data cleaning. I used the Layoffs 2022 dataset from Kaggle, which is basically a record of tech companies around the world and how many people they laid off. The raw file was pretty messy so I wanted to clean it up properly using MySQL before doing any actual analysis on it.

## Dataset

I got the dataset from Kaggle here: https://www.kaggle.com/datasets/swaptr/layoffs-2022

These are the columns in the raw table:

| Column | What it means |
|---|---|
| company | Name of the company |
| location | City where the company is based |
| industry | What industry the company is in |
| total_laid_off | Number of employees let go |
| percentage_laid_off | What percent of the workforce that was |
| date | When the layoff happened |
| stage | Company's funding stage (Series A, IPO, etc.) |
| country | Country of operation |
| funds_raised_millions | Total funds raised in millions |

## Why I did this

Honestly this is one of those beginner projects almost everyone learning SQL ends up doing, but I still learned a lot from it. Real datasets are rarely clean. This one had duplicate rows, inconsistent naming for the same thing, blank values, and a date column that was stored as plain text instead of an actual date. So the goal was to go through a proper cleaning process and end up with a table that's actually usable for analysis.

## Tools

I used MySQL Workbench for this. Main things I used were window functions, CTEs, joins, and some basic string functions like TRIM and STR_TO_DATE.

## What I did, step by step

**1. Made a staging table first**

Before touching anything, I copied the raw layoffs table into a new one called layoffs_staging. I did this because you should never clean or edit your raw data directly. If something goes wrong you want your original table untouched so you can always start over.

**2. Removed duplicates**

The table didn't have any kind of ID column, so I couldn't just check for duplicate IDs. Instead I used ROW_NUMBER() with PARTITION BY across all the columns to find rows that were exact copies of each other. Anything with a row number greater than 1 was a duplicate, so I created another table called layoffs_staging2 with that row number included, then deleted the duplicate rows from there.

**3. Standardized the data**

This part took a while. Some examples of what I fixed:

Trimmed extra spaces in the company column since some entries had leading or trailing whitespace.

Found a bunch of different versions of "Crypto" as an industry (like Crypto Currency, CryptoCurrency, etc.) and standardized all of them into just "Crypto".

Some country entries like "United States." had a trailing period while others didn't, so I cleaned those up too.

The date column was stored as text, not an actual date, so I converted it using STR_TO_DATE and then changed the column type to DATE.

**4. Dealt with null and blank values**

Some rows had blank industry values instead of actual NULLs, so I converted those to NULL first to keep things consistent. Then I noticed some companies had their industry filled in on one row but missing on another (like Airbnb), so I used a self join on the company column to find matching rows and fill in the missing industry from there.

**5. Removed rows and columns I didn't need**

Some rows had both total_laid_off and percentage_laid_off as NULL, which basically means there's no useful information there, so I deleted those. Lastly I dropped the row_num column since it was only there temporarily to help remove duplicates.

## End result

After all this, layoffs_staging2 is a clean table with no duplicates, consistent formatting, proper data types, and no rows that don't actually tell you anything. It's ready to use for actual analysis now, like looking at layoffs by industry or by country over time.

## Things I learned

Never clean data directly on the raw table, always work off a copy.

ROW_NUMBER with PARTITION BY is honestly such a useful trick for finding duplicates when there's no primary key to rely on.

Self joins are pretty handy for filling in missing info using other rows in the same table.

Only convert data types after you've already cleaned the data, otherwise you'll run into errors trying to convert messy text into a date or number.

