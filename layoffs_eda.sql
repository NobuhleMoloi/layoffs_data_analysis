-- LAYOFFS EXPLORATORY DATA ANALYSIS

SELECT *
FROM layoffs_staging2;


-- ======================
-- COMPANY
-- ======================

-- Total layoffs per company (absolute impact)
SELECT company, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY total_layoffs DESC;

-- Average layoff percentage per company (relative impact)
SELECT company, ROUND(AVG(percentage_laid_off),2) AS avg_percentage
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY company
ORDER BY avg_percentage DESC;


-- ======================
-- COUNTRY
-- ======================

-- Total layoffs per country
SELECT country, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY country
ORDER BY total_layoffs DESC;

-- Companies that shut down completely (100% layoffs) per country
SELECT country, COUNT(*) AS shutdowns
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY country
ORDER BY shutdowns DESC;


-- ======================
-- INDUSTRY
-- ======================

-- Shutdowns per industry (100% layoffs)
SELECT industry, COUNT(*) AS shutdowns
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY industry
ORDER BY shutdowns DESC;

-- Average layoff percentage per industry
SELECT industry, COUNT(*) AS company_count,
       ROUND(AVG(percentage_laid_off),2) AS avg_percentage
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY industry
ORDER BY avg_percentage DESC;


-- ======================
-- DATE
-- ======================

-- Dataset time range
SELECT MIN(`date`) AS start_date, MAX(`date`) AS end_date
FROM layoffs_staging2;

-- Yearly layoffs trend
SELECT 
    YEAR(`date`) AS `year`,
    COUNT(*) AS company_count,
    SUM(total_laid_off) AS total_layoffs,
    ROUND(AVG(percentage_laid_off),2) AS avg_percentage
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL 
AND percentage_laid_off IS NOT NULL
GROUP BY YEAR(`date`)
ORDER BY 1;

-- Monthly layoffs trend
SELECT 
    DATE_FORMAT(`date`,'%Y-%m') AS `year_month`,
    COUNT(*) AS company_count,
    SUM(total_laid_off) AS total_layoffs,
    ROUND(AVG(percentage_laid_off),2) AS avg_percentage
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL 
AND percentage_laid_off IS NOT NULL
GROUP BY DATE_FORMAT(`date`,'%Y-%m')
ORDER BY `year_month`;

-- Shutdowns per year
SELECT YEAR(`date`) AS year, COUNT(*) AS shutdowns
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY YEAR(`date`)
ORDER BY year;


-- ======================
-- STAGE
-- ======================

-- Layoffs by company stage
SELECT stage, COUNT(*) AS company_count,
       ROUND(AVG(percentage_laid_off),2) AS avg_percentage
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY stage
ORDER BY avg_percentage DESC;

-- Shutdowns by stage
SELECT stage, COUNT(*) AS shutdowns
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY stage
ORDER BY shutdowns DESC;


-- ======================
-- FINAL INSIGHTS
-- ======================

-- Total layoffs (absolute impact) and layoff percentage (relative impact) produce different rankings across companies, showing that scale and severity measure different effects.
-- The United States and India account for the highest total layoffs in the dataset, while shutdown frequency varies independently of total layoff volume.
-- Finance, Retail, and Healthcare record the highest average layoff percentages and also show high shutdown counts, indicating consistently higher workforce reduction severity in these industries.
-- Layoff activity is concentrated in specific time periods, with clear peaks across certain years and months rather than a uniform distribution over time.
-- Early-stage companies (Seed, Series A, Series B) record higher average layoff percentages and higher shutdown counts compared to later-stage companies.

-- ======================
-- LIMITATION
-- ======================

-- Dataset reflects reported layoffs only and may not capture all global events.
-- Some averages may be influenced by uneven sample sizes across countries, industries, and stages.