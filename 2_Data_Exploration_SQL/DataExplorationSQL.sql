-- Layoffs 2022 Exploratory Data Analysis
-- Data set: https://www.kaggle.com/datasets/swaptr/layoffs-2022
-- Table used: layoffs_staging2 (the cleaned version from the data cleaning script
-- Columns: Company, location, industry, total_laid_off, percentage_laid_off, date, stage, country

-- PART 1. JUST LOOKING AROUND
-- At this point I don't really have a specific question in mind yet, just want to poke around
-- the clean data and see what jumps out. Usually once you start looking you get ideas for
-- what to dig into further.

SELECT *
FROM layoffs_staging2;


-- EASY QUERIES FIRST

-- what's the single biggest layoff number in the whole data set
SELECT MAX(total_laid_off)
FROM layoffs_staging2;

-- checking the percentage column to get a sense of how big these layoffs actually were
-- relative to each company's workforce
SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL;

-- a percentage of 1 basically means the whole company got laid off, so let's see who that was
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1;
-- looks like these are mostly startups that shut down completely during this period

-- sorting those by funds raised to see how big some of these companies actually were before folding
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- BritishVolt pops up here too, an EV company. And Quibi, which had raised close to
-- 2 billion dollars before shutting down.


-- PART 2. GROUP BY QUERIES
-- Now getting into some slightly more involved stuff, mostly grouping and summing to compare
-- companies, locations, industries, etc against each other

-- biggest single layoff event (one company, one day)
SELECT company, total_laid_off
FROM layoffs_staging2
ORDER BY 2 DESC
LIMIT 5;
-- keep in mind this is just one event, not a company's total across the whole data set

-- companies with the highest total layoffs added up across the whole data set
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

-- same idea but by location
SELECT location, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

-- totals by country, covers the full time range in the data set
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- totals by year, so we can see which year had it worse
SELECT YEAR(date), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 1 ASC;

-- totals by industry
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- totals by company stage (Series A, IPO, etc.)
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;


-- PART 3. THE HARDER QUERIES
-- Now, we are trying to answer a slightly more specific question: instead of just the companies
-- with the most layoffs overall, which companies had the most layoffs each year

WITH Company_Year AS
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
),
Company_Year_Rank AS
(
  SELECT company, years, total_laid_off,
         DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;


-- rolling (running) total of layoffs per month, to see the trend build up over time
SELECT SUBSTRING(date, 1, 7) AS dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC;

-- wrapping the above in a CTE so I can run a window function on top of it to get the
-- actual running total instead of just monthly totals
WITH DATE_CTE AS
(
  SELECT SUBSTRING(date, 1, 7) AS dates, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY dates
  ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) AS rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;