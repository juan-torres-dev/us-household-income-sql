-- ===============================================================
-- US Household Income Project: Exploratory Data Analysis (EDA)
-- ===============================================================

-- Top 10 states by total land area (ALand)
SELECT State_Name, SUM(ALand) AS total_land_area, SUM(AWater) AS total_water_area
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY SUM(ALand) DESC
LIMIT 10;

-- Top 10 states by total water area (AWater)
SELECT State_Name, SUM(ALand) AS total_land_area, SUM(AWater) AS total_water_area
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY SUM(AWater) DESC
LIMIT 10;

-- ===============================================================
-- Join income and statistics tables (excluding zero Mean records)
-- ===============================================================

-- Preview joined records where Mean is not 0
SELECT *
FROM us_project.us_household_income AS u
INNER JOIN us_project.us_household_income_statistics AS us
	ON u.id = us.id
WHERE Mean <> 0;

-- Select key location and income columns
SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_project.us_household_income AS u
INNER JOIN us_project.us_household_income_statistics AS us
	ON u.id = us.id
WHERE Mean <> 0;

-- ===============================================================
-- Compare average Mean and Median income by State and Type
-- ===============================================================

-- Top 10 States by average Median income
SELECT u.State_Name, ROUND(AVG(Mean), 1) AS avg_mean, ROUND(AVG(Median), 1) AS avg_median
FROM us_project.us_household_income AS u
INNER JOIN us_project.us_household_income_statistics AS us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY ROUND(AVG(Median), 1) DESC
LIMIT 10;

-- Top 10 states by average Mean income
SELECT u.State_Name, ROUND(AVG(Mean), 1) AS avg_mean, ROUND(AVG(Median), 1) AS avg_median
FROM us_project.us_household_income AS u
INNER JOIN us_project.us_household_income_statistics AS us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY ROUND(AVG(Mean), 1) DESC
LIMIT 10;

-- Average Mean and Median income by area Type (top 20 by Mean)
SELECT Type, ROUND(AVG(Mean), 1) AS avg_mean, ROUND(AVG(Median), 1) AS avg_median
FROM us_project.us_household_income AS u
INNER JOIN us_project.us_household_income_statistics AS us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY ROUND(AVG(Mean), 1) DESC
LIMIT 20;

-- Include record count per Type to see sample sizes
SELECT Type, COUNT(Type) AS type_count, ROUND(AVG(Mean), 1) AS avg_mean, ROUND(AVG(Median), 1) AS avg_median
FROM us_project.us_household_income AS u
INNER JOIN us_project.us_household_income_statistics AS us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
ORDER BY ROUND(AVG(Mean), 1) DESC
LIMIT 20;

-- Filter to Types with more than 100 records, ordered by average Median
SELECT Type, COUNT(Type) AS type_count, ROUND(AVG(Mean), 1) AS avg_mean, ROUND(AVG(Median), 1) AS avg_median
FROM us_project.us_household_income AS u
INNER JOIN us_project.us_household_income_statistics AS us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
HAVING COUNT(Type) > 100
ORDER BY ROUND(AVG(Median), 1) DESC
LIMIT 20;

-- Inspect records where Type is 'Community'
SELECT *
FROM us_project.us_household_income
WHERE Type = 'Community';

-- Compare average Mean and Median income by State and City
SELECT u.State_Name, City, ROUND(AVG(Mean), 1) AS avg_mean, ROUND(AVG(Median), 1) AS avg_median
FROM us_project.us_household_income AS u
JOIN us_project.us_household_income_statistics AS us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean), 1) DESC;