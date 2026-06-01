/*
=======================================================
Script: step3.selecting_all_data_from_table.sql
Description: Select data from all dimension and fact tables
Purpose: Verify loaded data for ETL validation and review
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-29
=======================================================
*/

-- ============================================
-- Verify dim_customer
-- ============================================
SELECT *
FROM [PC_Sales_Staging_dtw].[dbo].[dim_customer];


-- ============================================
-- Verify dim_product
-- ============================================
SELECT *
FROM [PC_Sales_Staging_dtw].[dbo].[dim_product];


-- ============================================
-- Verify dim_shop
-- ============================================
SELECT *
FROM [PC_Sales_Staging_dtw].[dbo].[dim_shop];


-- ============================================
-- Verify dim_salesperson
-- ============================================
SELECT *
FROM [PC_Sales_Staging_dtw].[dbo].[dim_salesperson];


-- ============================================
-- Verify dim_paymentinfo
-- ============================================
SELECT *
FROM [PC_Sales_Staging_dtw].[dbo].[dim_paymentinfo];


-- ============================================
-- Verify dim_date
-- ============================================
SELECT *
FROM [PC_Sales_Staging_dtw].[dbo].[dim_date];


-- ============================================
-- Verify fact_sales
-- ============================================
SELECT *
FROM [PC_Sales_Staging_dtw].[dbo].[fact_sales];