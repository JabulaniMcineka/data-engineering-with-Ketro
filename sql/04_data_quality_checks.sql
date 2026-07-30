/*
=======================================================
Script: step4.data_validation_and_cleaning.sql
Description: Validates ETL load and checks data quality
Purpose: Ensure dimensions and fact table loaded correctly
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-29
=======================================================
*/

PRINT 'Starting data validation checks...';

-- ============================================
-- 1. Check raw staging data quality
-- ============================================
SELECT TOP 100 *
FROM dbo.pc_data
WHERE Purchase_Date = 'N/A'
   OR Ship_Date = 'N/A'
   OR Sale_Price IS NULL;

PRINT 'Raw data quality check complete';


-- ============================================
-- 2. Validate dimension row counts
-- ============================================
SELECT 'dim_customer' AS TableName, COUNT(*) AS RowCount FROM dbo.dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*) FROM dbo.dim_product
UNION ALL
SELECT 'dim_shop', COUNT(*) FROM dbo.dim_shop
UNION ALL
SELECT 'dim_salesperson', COUNT(*) FROM dbo