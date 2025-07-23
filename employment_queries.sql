-- View all data
SELECT * FROM employment;

-- Filter by region
SELECT * FROM employment WHERE region = 'Auckland';

-- Average employment rate by year
SELECT year, AVG(employment_rate) AS avg_rate
FROM employment
GROUP BY year;

-- Region with highest employment in 2021
SELECT region, employment_rate
FROM employment
WHERE year = 2021
ORDER BY employment_rate DESC
LIMIT 1;
