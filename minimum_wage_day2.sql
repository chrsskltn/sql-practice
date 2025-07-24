-- Day 2: NZ Minimum Wage SQL Challenge
-- Source: employment.govt.nz
-- Data accurate to July 2025

-- Drop the table if it exists (safe re-run)
DROP TABLE IF EXISTS minimum_wage;

-- Create the table
CREATE TABLE minimum_wage (
    year INTEGER,
    age_group TEXT,
    rate_type TEXT,
    hourly_rate REAL
);

-- Insert real NZ minimum wage data (2020–2024)
INSERT INTO minimum_wage VALUES
(2020, 'All', 'Adult', 18.90),
(2020, '16-17', 'Starting Out', 15.12),
(2020, '16-19', 'Training', 15.12),
(2021, 'All', 'Adult', 20.00),
(2021, '16-17', 'Starting Out', 16.00),
(2021, '16-19', 'Training', 16.00),
(2022, 'All', 'Adult', 21.20),
(2022, '16-17', 'Starting Out', 16.96),
(2022, '16-19', 'Training', 16.96),
(2023, 'All', 'Adult', 22.70),
(2023, '16-17', 'Starting Out', 18.16),
(2023, '16-19', 'Training', 18.16),
(2024, 'All', 'Adult', 23.15),
(2024, '16-17', 'Starting Out', 18.52),
(2024, '16-19', 'Training', 18.52);

-- 🔍 Challenge 1: What is the latest adult minimum wage?
SELECT MAX(year) AS year, hourly_rate
FROM minimum_wage
WHERE rate_type = 'Adult';

-- 🔍 Challenge 2: Show adult minimum wage year-over-year
SELECT year, hourly_rate
FROM minimum_wage
WHERE rate_type = 'Adult'
ORDER BY year;

-- 🔍 Challenge 3: Which rate type had the highest percentage increase from 2020 to 2024?

-- Step 1: Get 2020 + 2024 rates for each rate type
WITH rate_changes AS (
  SELECT
    rate_type,
    MAX(CASE WHEN year = 2020 THEN hourly_rate END) AS rate_2020,
    MAX(CASE WHEN year = 2024 THEN hourly_rate END) AS rate_2024
  FROM minimum_wage
  GROUP BY rate_type
)
-- Step 2: Calculate percentage change
SELECT
  rate_type,
  rate_2020,
  rate_2024,
  ROUND(((rate_2024 - rate_2020) / rate_2020) * 100, 2) AS percent_increase
FROM rate_changes
ORDER BY percent_increase DESC;

-- 🔍 Challenge 4: Average minimum wage per year (all rate types)
SELECT year, ROUND(AVG(hourly_rate), 2) AS avg_rate
FROM minimum_wage
GROUP BY year
ORDER BY year;

-- 🔍 Challenge 5: Year-over-year change in adult wage
WITH adult_wage AS (
  SELECT year, hourly_rate
  FROM minimum_wage
  WHERE rate_type = 'Adult'
)
SELECT
  a.year,
  a.hourly_rate,
  ROUND(a.hourly_rate - b.hourly_rate, 2) AS delta
FROM adult_wage a
JOIN adult_wage b ON a.year = b.year + 1
ORDER BY a.year;