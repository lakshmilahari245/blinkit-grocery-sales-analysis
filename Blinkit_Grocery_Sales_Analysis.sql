-- ============================================
-- BLINKIT GROCERY SALES ANALYSIS
-- SQL SERVER PROJECT
-- ============================================

USE blinkit;
GO

-- ============================================
-- 1. DATA QUALITY CHECKS
-- ============================================

-- Total records
SELECT COUNT(*) AS Total_Rows
FROM dbo.blinkit_sales;

-- NULL checks
SELECT COUNT(*) AS Null_Item_Weight
FROM dbo.blinkit_sales
WHERE Item_Weight IS NULL;

SELECT COUNT(*) AS Null_Outlet_Size
FROM dbo.blinkit_sales
WHERE Outlet_Size IS NULL;

SELECT COUNT(*) AS Null_Item_Outlet_Sales
FROM dbo.blinkit_sales
WHERE Item_Outlet_Sales IS NULL;

-- Check categorical values
SELECT DISTINCT Item_Fat_Content
FROM dbo.blinkit_sales;

SELECT DISTINCT Outlet_Size
FROM dbo.blinkit_sales;

SELECT DISTINCT Outlet_Location_Type
FROM dbo.blinkit_sales;

SELECT DISTINCT Outlet_Type
FROM dbo.blinkit_sales;

-- Numerical validation
SELECT
    MIN(Item_MRP) AS Minimum_MRP,
    MAX(Item_MRP) AS Maximum_MRP,
    AVG(Item_MRP) AS Average_MRP
FROM dbo.blinkit_sales;

-- Duplicate Item + Outlet combinations
SELECT
    Item_Identifier,
    Outlet_Identifier,
    COUNT(*) AS Duplicate_Count
FROM dbo.blinkit_sales
GROUP BY Item_Identifier, Outlet_Identifier
HAVING COUNT(*) > 1;


-- ============================================
-- 2. DATA CLEANING
-- ============================================

-- Standardize inconsistent fat-content labels
UPDATE dbo.blinkit_sales
SET Item_Fat_Content = 'Low Fat'
WHERE Item_Fat_Content IN ('LF', 'low fat');

UPDATE dbo.blinkit_sales
SET Item_Fat_Content = 'Regular'
WHERE Item_Fat_Content = 'reg';

-- Verify cleaned values
SELECT DISTINCT Item_Fat_Content
FROM dbo.blinkit_sales;


-- ============================================
-- 3. KPI ANALYSIS
-- ============================================

-- KPI 1: Total Sales
SELECT
    SUM(Item_Outlet_Sales) AS Total_Sales
FROM dbo.blinkit_sales;

-- KPI 2: Average Sales
SELECT
    AVG(Item_Outlet_Sales) AS Average_Sales
FROM dbo.blinkit_sales;

-- KPI 3: Total Records
SELECT
    COUNT(*) AS Total_Records
FROM dbo.blinkit_sales;

-- KPI 4: Average MRP
SELECT
    AVG(Item_MRP) AS Average_MRP
FROM dbo.blinkit_sales;


-- ============================================
-- 4. PRODUCT ANALYSIS
-- ============================================

-- Sales by Item Type
SELECT
    Item_Type,
    SUM(Item_Outlet_Sales) AS Total_Sales
FROM dbo.blinkit_sales
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

-- Sales by Fat Content
SELECT
    Item_Fat_Content,
    SUM(Item_Outlet_Sales) AS Total_Sales
FROM dbo.blinkit_sales
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;

-- Highest-selling Product Category
WITH Highestsales AS
(
    SELECT
        Item_Type,
        SUM(Item_Outlet_Sales) AS Total_Sales,
        DENSE_RANK() OVER
        (
            ORDER BY SUM(Item_Outlet_Sales) DESC
        ) AS rnk
    FROM dbo.blinkit_sales
    GROUP BY Item_Type
)
SELECT
    Item_Type,
    Total_Sales
FROM Highestsales
WHERE rnk = 1;


-- ============================================
-- 5. OUTLET ANALYSIS
-- ============================================

-- Sales by Outlet Type
SELECT
    Outlet_Type,
    SUM(Item_Outlet_Sales) AS Total_Sales
FROM dbo.blinkit_sales
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;

-- Sales by Outlet Size
SELECT
    Outlet_Size,
    SUM(Item_Outlet_Sales) AS Total_Sales
FROM dbo.blinkit_sales
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-- Sales by Location Type
SELECT
    Outlet_Location_Type,
    SUM(Item_Outlet_Sales) AS Total_Sales
FROM dbo.blinkit_sales
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- Average Sales by Location Type
SELECT
    Outlet_Location_Type,
    AVG(Item_Outlet_Sales) AS Average_Sales
FROM dbo.blinkit_sales
GROUP BY Outlet_Location_Type;

-- Outlet Type + Location combination
SELECT
    Outlet_Type,
    Outlet_Location_Type,
    SUM(Item_Outlet_Sales) AS Total_Sales
FROM dbo.blinkit_sales
GROUP BY Outlet_Type, Outlet_Location_Type
ORDER BY Total_Sales DESC;


-- ============================================
-- 6. OPTIONAL PRICE SEGMENTATION
-- ============================================

SELECT
    CASE
        WHEN Item_MRP < 50 THEN 'Budget'
        WHEN Item_MRP BETWEEN 50 AND 100 THEN 'Mid Range'
        WHEN Item_MRP BETWEEN 100 AND 200 THEN 'Premium'
        ELSE 'High'
    END AS Price_Range,
    COUNT(*) AS Item_Count,
    SUM(Item_Outlet_Sales) AS Total_Sales,
    AVG(Item_Outlet_Sales) AS Average_Sales
FROM dbo.blinkit_sales
GROUP BY
    CASE
        WHEN Item_MRP < 50 THEN 'Budget'
        WHEN Item_MRP BETWEEN 50 AND 100 THEN 'Mid Range'
        WHEN Item_MRP BETWEEN 100 AND 200 THEN 'Premium'
        ELSE 'High'
    END
ORDER BY Total_Sales DESC;
