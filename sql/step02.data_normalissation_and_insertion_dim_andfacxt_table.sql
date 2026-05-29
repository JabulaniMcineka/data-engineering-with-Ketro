/*
=======================================================
Script: step2.data_normalisation_and_insertion_dim_and_fact_tables.sql
Description: Normalize raw data into separated staging dimension and fact tables
Purpose: Extract distinct records from pc_data into logical subject-area tables
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-29
=======================================================
*/

-- ============================================
-- CUSTOMER TABLE
-- ============================================
SELECT DISTINCT
    [Customer_Name],
    [Customer_Surname],
    [Customer_Contact_Number],
    [Customer_Email_Address],
    [Credit_Score],
    [Priority]
INTO [PC_Sales_Staging_dtw].[dbo].[stg_customer]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];


-- ============================================
-- PRODUCT TABLE
-- ============================================
SELECT DISTINCT
    [PC_Make],
    [PC_Model],
    [Storage_Capacity],
    [RAM],
    [PC_Market_Price],
    [Storage_Type],
    [Cost_of_Repairs]
INTO [PC_Sales_Staging_dtw].[dbo].[stg_product]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];


-- ============================================
-- SHOP TABLE
-- ============================================
SELECT DISTINCT
    [Shop_Name],
    [Shop_Age],
    [Continent],
    [Country_or_State],
    [Province_or_City]
INTO [PC_Sales_Staging_dtw].[dbo].[stg_shop]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];


-- ============================================
-- SALESPERSON TABLE
-- ============================================
SELECT DISTINCT
    [Sales_Person_Name],
    [Sales_Person_Department],
    [Total_Sales_per_Employee]
INTO [PC_Sales_Staging_dtw].[dbo].[stg_salesperson]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];


-- ============================================
-- PAYMENT TABLE
-- ============================================
SELECT DISTINCT
    [Payment_Method],
    [Channel],
    [Discount_Amount],
    [Finance_Amount]
INTO [PC_Sales_Staging_dtw].[dbo].[stg_payment]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];


-- ============================================
-- DATE TABLE
-- ============================================
SELECT DISTINCT
    [Purchase_Date],
    [Ship_Date]
INTO [PC_Sales_Staging_dtw].[dbo].[stg_date]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];


-- ============================================
-- FACT SALES TABLE
-- ============================================
SELECT DISTINCT
    [Cost_Price],
    [Sale_Price],
    [Discount_Amount],
    [Finance_Amount],
    [Credit_Score],
    [Cost_of_Repairs],
    [Total_Sales_per_Employee],
    [PC_Market_Price]
INTO [PC_Sales_Staging_dtw].[dbo].[fact_sales_stg]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];