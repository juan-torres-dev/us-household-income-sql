-- ============================================================
-- US Household Income Project: Data Cleaning
-- ============================================================

-- Identify duplicate `id` records in us_household_income
SELECT id, COUNT(id) AS duplicate_count
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;

-- Preview duplicate rows (keeping the first occurrence per `id`)
SELECT *
FROM (
	SELECT row_id,
		   id,
		   ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
	FROM us_project.us_household_income
) AS duplicates
WHERE row_num > 1;

-- Remove duplicate rows where row_num > 1
DELETE FROM us_project.us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT
			row_id,
			id,
			ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_project.us_household_income
	) AS duplicates
	WHERE row_num > 1);

-- Check us_household_income_statistics for duplicate `id` values
SELECT id, COUNT(id) AS duplicate_count
FROM us_project.us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1;

-- ============================================================
-- Standardize State_Name, Place, and Type values
-- ============================================================

-- Review distinct state names for typos or casing inconsistencies
SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY State_Name;

UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

-- Inspect Autauga County records and fill missing Place for Vinemont
SELECT  *
FROM us_project.us_household_income
WHERE County = 'Autauga County';

UPDATE us_project.us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

-- Review Type counts and standardize plural 'Boroughs' to 'Borough'
SELECT  Type, COUNT(Type) AS type_count
FROM us_project.us_household_income
GROUP BY Type;

UPDATE us_project.us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

-- ============================================================
-- Check for rows with zero, blank, or NULL land and water area
-- ============================================================
SELECT ALand, AWater
FROM us_project.us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL);