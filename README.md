# US Household Income SQL Cleaning & Exploratory Analysis

A MySQL portfolio project covering data cleaning and exploratory data analysis (EDA) across `us_household_income` and `us_household_income_statistics` tables.

## Project Structure

- `data/` - Raw source data files (`.csv` / `.json`) used to populate the database tables.
- `us_household_income_project_cleaning.sql` - Identifies and removes duplicate records, standardizes state/place/area-type values, and checks for missing or zero land/water area values.
- `us_household_income_project_eda.sql` - Aggregates land and water area by state, joins household income statistics, and compares average mean and median incomes across states, area types, and cities.

## How to Run

1. Create a schema named `us_project` in **MySQL Workbench** (or another MySQL client).
2. Import the raw data files from the `data/` folder into `us_project.us_household_income` and `us_project.us_household_income_statistics`.
3. Run `us_household_income_project_cleaning.sql` first to remove duplicates and standardize values.
4. Run `us_household_income_project_eda.sql` to execute the exploratory queries.

## Key SQL Techniques Used

- **Deduplication:** `ROW_NUMBER() OVER (PARTITION BY ...)` with `GROUP BY` / `HAVING` to spot and delete duplicate rows.
- **Data Standardization:** `UPDATE` statements with `WHERE` filters to fix misspellings/casing (`georia`, `alabama`), fill missing `Place` values, and normalize `Type` labels (`Boroughs` to `Borough`).
- **Joins & Aggregations:** `INNER JOIN` / `JOIN`, `ROUND()`, `AVG()`, `SUM()`, `COUNT()`, `GROUP BY`, `HAVING`, and `ORDER BY`.

## Key Takeaways / Findings

- **Data Quality:** Deduplicated records prior to analysis and standardized inconsistent text values, correcting `State_Name` typos and casing (`georia` to `Georgia`, `alabama` to `Alabama`), populating missing `Place` values (`Autaugaville` for Vinemont in Autauga County), and consolidating `Type` labels (`Boroughs` to `Borough`) so groupings were not split across formatting variations.
- **Geographic & Area Trends:** **Alaska** leads both total land area (`687,980,271,099`) and total water area (`108,215,793,348`), with **Texas** (`255,101,948,685`), **Oregon** (`157,891,279,338`), and **California** (`154,887,010,272`) next in land area, and **Michigan** (`24,501,465,830`), **Texas** (`8,550,139,502`), and **Florida** (`7,537,705,989`) trailing Alaska in water area. At the city level, **Delta Junction, AK** (`242,857`), **Short Hills, NJ** (`216,503`), and **Narberth, PA** (`194,426`) top average `Mean` income, with several entries hitting a `300,000` median cap (NOTE: `300,000` is potentially the cutoff point for tracking of Median values) and notable differences between `Mean` and `Median` figures across cities.
- **Area Type Breakdown:** Among area `Type` categories with over 100 records (`Mean <> 0`), **CDP** has the highest average median income (`116,376.6` across `962` records), while **Borough** (`68,594.4`) and **Track** (`29,174` records; `68,086.2` mean) lead in average mean income, ahead of **Village** (`72,316.7` median / `61,548.6` mean), **City** (`64,850.4` median / `58,220.8` mean), and **Town** (`63,846.6` median / `55,194.1` mean).

## Notes

- `SET SQL_SAFE_UPDATES = 0;` may be required in MySQL Workbench before running `UPDATE` or `DELETE` statements if safe updates are enabled.
- If importing raw files via the MySQL Table Data Import Wizard, verify column headers for any hidden UTF-8 BOM (`EFBBBF`) characters that could affect column name matching.
