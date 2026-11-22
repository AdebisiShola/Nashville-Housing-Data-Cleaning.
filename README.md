# Nashville Housing Data Cleaning Project

## Project Overview
This project focuses on cleaning and transforming the Nashville Housing dataset using Microsoft SQL Server Management Studio (SSMS).

The objective was to improve data quality, handle missing values, standardise information, remove duplicate records, and prepare the dataset for further analysis.

## Tools Used
- Microsoft SQL Server Management Studio (SSMS)
- SQL (T-SQL)
- CSV Dataset

## Data Cleaning Techniques

The following operations were explored and implemented in this project:

1. **Date Standardisation:** Converted sale dates into the SQL DATE format.
2. **Handling Missing Values:** Used self-joins and ISNULL() to populate missing property addresses.
3. **Address Parsing:** Used SUBSTRING(), CHARINDEX(), PARSENAME(), and REPLACE() to separate property and owner addresses into individual columns.
4. **Data Standardisation:** Explored CASE statements to standardise the SoldAsVacant field.
5. **Duplicate Removal:** Used ROW_NUMBER() and Common Table Expressions (CTEs) to identify and remove duplicate records.
6. **Column Management:** Used ALTER TABLE and DROP COLUMN to remove selected unused columns.

## SQL Concepts Applied
- SELECT statements
- UPDATE statements
- ALTER TABLE
- CASE WHEN
- JOINs
- ISNULL()
- SUBSTRING()
- CHARINDEX()
- PARSENAME()
- ROW_NUMBER()
- Common Table Expressions (CTEs)
- DELETE statements

## Project Files
- `Nashville_Housing_Data_Cleaning.sql` – SQL queries used for data cleaning.
- `Nashville Housing Data for Data Cleaning.csv` – Original dataset.

## Learning Outcomes
Through this project, I gained practical experience in:
- Preparing raw datasets for analysis.
- Identifying and handling missing values.
- Working with SQL string functions.
- Detecting and removing duplicate records.
- Applying SQL transformations to improve data quality.

## Conclusion
This project strengthened my understanding of SQL data cleaning techniques and provided practical experience in preparing datasets for meaningful analysis.

**Author:** Oluwashola Adebisi
