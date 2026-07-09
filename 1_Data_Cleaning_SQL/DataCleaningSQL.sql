-- Data Cleaning Project in SQL
-- Data set: https://www.kaggle.com/datasets/swaptr/layoffs-2022
-- Columns: Company, location, industry, total_laid_off, percentage_laid_off, date, stage, country

SELECT *
FROM layoffs;

-- PART 1. CREATING THE STAGING TABLE
-- The first part is to create a staging table WHERE all the data cleaning will be done. This keeps the original raw data table intact and untouched, serving as a backup in case anything goes wrong during the cleaning process.

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- PART 2. DATA CLEANING
-- The following steps are employed in order to clean the data set

-- 1. Remove duplicates
-- 2. Standardize the data set
-- 3. Look at null values or blank values
-- 4. Remove any unnecessary columns and rows



-- 1. REMOVING DUPLICATES

-- Here, we take look into finding the duplicates by taking into account all rows, not just one.
SELECT *,
ROW_NUMBER() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`,stage, country,
funds_raised_millions) as row_num
FROM layoffs_staging; 

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num> 1;

-- Here, we create a staging table 2 to DELETE duplicate rows. We basically want to DELETE the rows WHERE is row_num is > 1
-- What we did here is to add a new colum in the new staging table showing the row numbers and then DELETE the rows WHERE the row_num > 1. 

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

Insert into layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`,stage, country,
funds_raised_millions) as row_num
FROM layoffs_staging; 

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- Checking to see if the the duplicates are removed

SELECT * 
FROM layoffs_staging2;


-- 2. STANDARDIZING DATA
-- Here, we remove the additional spaces after the entries in the company column.
SELECT company, (TRIM(Company))
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2;
ORDER BY 1;

-- Here, we noticed multiple variations for the "crypto" industry. We find similar entries for the industry "crpyto"
SELECT DISTINCT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- updating and standardizing the entries for crypto
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Here, we find similar variations for the country "United States"
-- We also update and standardize the entries for United States
SELECT DISTINCT country, Trim(TRAILING '.' FROM country)
FROM layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET country = TRIM(Trailing '.' FROM country)
WHERE country like 'United States%';

SELECT distinct country
FROM layoffs_staging2
order by 1;

-- Here, we change the data type of date FROM text to number.
-- we can use str to date to update this field

SELECT `date`
FROM layoffs_staging2;

Update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y');

-- never change the data type of a raw table
ALTER TABLE  layoffs_staging2
Modify column `date` DATE;

-- 3. WORKING WITH NULLS AND UNKNOWNS

UPDATE layoffs_staging2
SET industry is null
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE industry is null
or industry = '';

-- Here, we find out that the industry entry for one row WHERE the company is "Airbnb" is empty. We try to populate 
-- the missing entry by searching for rows with the same company.
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	on t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL or t1.industry = '')
AND t2.industry IS NOT NULL;

-- Here, we update the data set by populating the rows where industry is NULL or empty.

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	on t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry is null
and t2.industry is not null;

-- 4. REMOVING UNNECESARY ROWS AND COLUMNS
-- Here, we delete the rows where the total_laid_off and percentage_laid_off are null
SELECT *
FROM layoffs_staging2
WHERE total_laid_off is null
and percentage_laid_off is null;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off is null
and percentage_laid_off is null;

-- Here, we delete the temporary column "row_num" which was used earlier to remove duplicate entries
Alter table layoffs_staging2
drop column row_num;

SELECT *
FROM layoffs_staging2;

