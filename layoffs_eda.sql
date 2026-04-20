-- =====================================================
-- EXPLORATORY DATA ANALYSIS: LAYOFFS DATASET
-- =====================================================

SELECT *
FROM layoffs_staging2;

-- =====================================================
-- COMPANY
-- =====================================================

-- Total layoffs per company (absolute impact)
SELECT company, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY total_layoffs DESC;

-- Average layoff percentage per company (severity)
SELECT company, ROUND(AVG(percentage_laid_off),2) AS avg_percentage
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY company
ORDER BY avg_percentage DESC;

/* Insight:
Companies with the highest total layoffs are primarily large, established firms (e.g Amazon and Google), reflecting workforce scale rather than severity.

Companies with the highest layoff percentages represent smaller or more vulnerable organizations, where layoffs impact a larger share of the workforce.

This highlights a clear distinction between high-impact layoffs (large companies affecting many employees) and high-severity layoffs (smaller companies cutting a larger proportion of staff).

Total layoffs alone do not accurately represent workforce risk without considering percentage reductions.
*/


-- =====================================================
-- COUNTRY
-- =====================================================

-- Total layoffs per country
SELECT country, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
WHERE total_laid_off IS NOT NULL
GROUP BY country
ORDER BY total_layoffs DESC;

-- Number of companies that shut down (100% layoffs)
SELECT country, COUNT(*) AS shutdown_count
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY country
ORDER BY shutdown_count DESC;

-- Average layoff percentage per country
SELECT country, ROUND(AVG(percentage_laid_off),2) AS avg_percentage
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY country
ORDER BY avg_percentage DESC;

/* Insight:
Layoffs are heavily concentrated in a small number of countries, with the United States and India contributing the highest total layoffs.

However, high total layoffs do not necessarily correspond to higher shutdown rates, indicating that layoffs in some countries are driven by large companies reducing workforce size rather than widespread company failure.

Differences in average layoff percentages across countries suggest variation in how workforce reductions are distributed, though results may be influenced by unequal representation across regions.
*/


-- =====================================================
-- INDUSTRY
-- =====================================================

-- Shutdowns per industry
SELECT industry, COUNT(*) AS shutdown_count
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY industry
ORDER BY shutdown_count DESC;

-- Average layoff percentage per industry
SELECT industry, COUNT(*) AS company_count,
       ROUND(AVG(percentage_laid_off),2) AS avg_percentage
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY industry
ORDER BY avg_percentage DESC;

/* Insight:
Industries such as Finance, Retail, and Healthcare show both high average layoff percentages and high shutdown counts, indicating consistent pressure across multiple dimensions.

These industries are not only experiencing frequent layoffs, but also more severe workforce reductions and higher rates of complete company closure.

This suggests structural vulnerability within these sectors, where companies are more exposed to economic shifts and operational instability.
*/


-- =====================================================
-- DATE
-- =====================================================

-- Dataset time range
SELECT MIN(`date`) AS start_date,
       MAX(`date`) AS end_date
FROM layoffs_staging2;

-- Yearly trends
WITH yearly_data AS (
    SELECT YEAR(`date`) AS `year`,
           COUNT(*) AS company_count,
           SUM(total_laid_off) AS total_layoffs,
           ROUND(AVG(percentage_laid_off),2) AS avg_percentage
    FROM layoffs_staging2
    WHERE total_laid_off IS NOT NULL
      AND percentage_laid_off IS NOT NULL
    GROUP BY YEAR(`date`)
)
SELECT *,
       RANK() OVER (ORDER BY company_count DESC, total_layoffs DESC) AS rank_year
FROM yearly_data;

-- Monthly trends
WITH monthly_data AS (
    SELECT DATE_FORMAT(`date`, '%Y-%m') AS `month`,
           COUNT(*) AS company_count,
           SUM(total_laid_off) AS total_layoffs,
           ROUND(AVG(percentage_laid_off),2) AS avg_percentage
    FROM layoffs_staging2
    WHERE total_laid_off IS NOT NULL
      AND percentage_laid_off IS NOT NULL
    GROUP BY DATE_FORMAT(`date`, '%Y-%m')
)
SELECT *,
       RANK() OVER (ORDER BY company_count DESC, total_layoffs DESC) AS rank_month
FROM monthly_data;

/* Insight:
Layoffs are concentrated in distinct periods rather than evenly distributed over time.

Peak activity occurs in specific months and years (e.g., early 2020 and during 2022), where both company participation and total layoffs are highest.

These spikes indicate that layoffs are driven by broader economic conditions rather than isolated company-level decisions.
*/


-- =====================================================
-- STAGE
-- =====================================================

-- Average layoff percentage per stage
SELECT stage, COUNT(*) AS company_count,
       ROUND(AVG(percentage_laid_off),2) AS avg_percentage
FROM layoffs_staging2
WHERE percentage_laid_off IS NOT NULL
GROUP BY stage
ORDER BY avg_percentage DESC;

-- Shutdowns per stage
SELECT stage, COUNT(*) AS shutdown_count
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY stage
ORDER BY shutdown_count DESC;

/* Insight:
Early-stage companies (Seed, Series A, Series B) show higher average layoff percentages and higher shutdown counts compared to later-stage companies.

This indicates that less established companies are more vulnerable to economic pressure, with fewer resources and less operational stability to absorb shocks.

In contrast, later-stage companies tend to reduce workforce size without reaching full shutdown, reflecting greater resilience.
*/
