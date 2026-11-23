# US Household Income SQL Cleaning & Exploratory Analysis

A MySQL portfolio project covering data cleaning and exploratory data analysis (EDA) across `us_household_income` and `us_household_income_statistics` tables.

## How to Run

- Open the `.sql` scripts in **MySQL Workbench** (or another MySQL client) connected to a database containing the `us_project` schema (`us_household_income` and `us_household_income_statistics` tables).
- Run `us_household_income_project_cleaning.sql` first to clean duplicates and standardize values, followed by `us_household_income_project_eda.sql` to explore the results.

## Project Structure

- `us_household_income_project_cleaning.sql` — Identifies and removes duplicate records, standardizes state/place/area-type values, and checks for missing or zero land/water area values.
- `us_household_income_project_eda.sql` — Aggregates land and water area by state, joins household income statistics, and compares average mean and median incomes across states, area types, and cities.

## Key SQL Techniques Used

- **Deduplication:** `ROW_NUMBER() OVER (PARTITION BY ...)` with `GROUP BY` / `HAVING` to spot and delete duplicate rows.
- **Data Standardization:** `UPDATE` statements with `WHERE` filters to fix misspellings/casing (`georia`, `alabama`), fill missing `Place` values, and normalize `Type` labels (`Boroughs` to `Borough`).
- **Joins & Aggregations:** `INNER JOIN` / `JOIN`, `ROUND()`, `AVG()`, `SUM()`, `COUNT()`, `GROUP BY`, `HAVING`, and `ORDER BY`.

## Key Takeaways / Findings

- **Data Quality:** *(Add what you noticed after deduplicating `id` rows and standardizing `State_Name`, `Place`, and `Type` values.)*
- **Geographic & Area Trends:** *(Add which states had the highest land or water area, and how mean vs. median income compared across top states and cities.)*
- **Area Type Breakdown:** *(Add notable patterns across area `Type` categories, especially when filtering to larger sample sizes like `COUNT(Type) > 100`.)*

## Notes

- Queries target the `us_project` schema (`us_project.us_household_income` and `us_project.us_household_income_statistics`).
- `SET SQL_SAFE_UPDATES = 0;` may be required in MySQL Workbench before running `UPDATE` or `DELETE` statements if safe updates are enabled.
