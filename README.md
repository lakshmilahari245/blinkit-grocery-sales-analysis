[README.md](https://github.com/user-attachments/files/31333678/README.md)
# blinkit-grocery-sales-analysis
Blinkit Grocery Sales Analysis using SQL Server — KPI analysis, data cleaning, aggregation, CTEs and window functions.
# Blinkit Grocery Sales Analysis Using SQL

## Project Overview

This project analyzes Blinkit grocery sales data using SQL Server to understand product performance, outlet performance, sales KPIs, and business trends.

## Business Objective

The objective is to answer questions such as:

- What is the total sales revenue?
- What is the average sales value?
- Which product categories generate the highest sales?
- Do Low Fat or Regular products generate more sales?
- Which outlet sizes and location tiers perform best?
- Which outlet type and location combination generates the highest sales?

## Dataset

The dataset contains **8,523 product-outlet records** and includes:

- Item Identifier
- Item Weight
- Item Fat Content
- Item Visibility
- Item Type
- Item MRP
- Outlet Identifier
- Outlet Establishment Year
- Outlet Size
- Outlet Location Type
- Outlet Type
- Item Outlet Sales

## Tools

- SQL Server
- SQL Server Management Studio (SSMS)
- SQL
- Excel/CSV

## Data Cleaning

The project includes:

- NULL-value checks
- Duplicate checks
- Distinct-value checks for categorical columns
- Numerical validation using MIN, MAX and AVG
- Standardization of inconsistent `Item_Fat_Content` labels:
  - `LF` → `Low Fat`
  - `reg` → `Regular`

## KPI Results

Based on the imported dataset:

| KPI | Result |
|---|---:|
| Total Sales | ₹18,591,125.42 |
| Average Sales | ₹2,181.29 |
| Total Records | 8,523 |
| Average MRP | ₹140.99 |

## Analysis Performed

### Product Analysis

- Total sales by item type
- Total sales by fat content
- Highest-selling product category using `CTE` and `DENSE_RANK()`

### Outlet Analysis

- Sales by outlet type
- Sales by outlet size
- Sales by location tier
- Average sales by location tier
- Outlet type + location combination

### SQL Concepts Demonstrated

- `SELECT`
- `WHERE`
- `COUNT`
- `SUM`
- `AVG`
- `MIN`
- `MAX`
- `DISTINCT`
- `GROUP BY`
- `ORDER BY`
- `HAVING`
- `CASE`
- CTE
- `DENSE_RANK()`
- Window Functions
- Data Cleaning

## Key Findings

- The dataset contains 8,523 records.
- Total sales are approximately ₹18.59 million.
- Fruits and Vegetables was the highest-selling product category in the initial analysis.
- Medium-sized outlets generated the highest sales among the identified outlet sizes.
- Supermarket Type 1 contributed the largest sales among outlet types in the initial analysis.
- Location and outlet format combinations show differences in sales performance.

> Note: Fat-content results should be interpreted after the standardization queries are executed because the raw dataset contains labels such as `LF` and `reg`.

## Business Value

The analysis can help a retail business identify high-performing product categories, outlet formats and location segments, supporting decisions around inventory, outlet strategy and sales optimization.

## Project File

`Blinkit_Grocery_Sales_Analysis.sql` contains the SQL queries used for data-quality checks, cleaning, KPI calculations and business analysis.
