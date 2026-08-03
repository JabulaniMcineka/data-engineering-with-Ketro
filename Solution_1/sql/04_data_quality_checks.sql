/*
=======================================================
Script: data_quality_checks.sql
Description: Validates ETL load and checks data quality
Purpose: Ensure dimensions and fact table loaded correctly
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-29
=======================================================
*/
USE PC_Data_DB;
GO



SELECT 
    'Continent' AS ColumnName,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Continent IS NULL THEN 1 ELSE 0 END) AS null_count,
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Continent, ''))) = '' THEN 1 ELSE 0 END) AS blank_count,
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Continent))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END) AS placeholder_count
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Country_or_State',
    COUNT(*),
    SUM(CASE WHEN Country_or_State IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Country_or_State, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Country_or_State))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Province_or_City',
    COUNT(*),
    SUM(CASE WHEN Province_or_City IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Province_or_City, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Province_or_City))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Shop_Name',
    COUNT(*),
    SUM(CASE WHEN Shop_Name IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Shop_Name, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Shop_Name))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Shop_Age',
    COUNT(*),
    SUM(CASE WHEN Shop_Age IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Shop_Age, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Shop_Age))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Customer_Name',
    COUNT(*),
    SUM(CASE WHEN Customer_Name IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Customer_Name, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Customer_Name))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Customer_Surname',
    COUNT(*),
    SUM(CASE WHEN Customer_Surname IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Customer_Surname, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Customer_Surname))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Customer_Contact_Number',
    COUNT(*),
    SUM(CASE WHEN Customer_Contact_Number IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Customer_Contact_Number, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Customer_Contact_Number))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Customer_Email_Address',
    COUNT(*),
    SUM(CASE WHEN Customer_Email_Address IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Customer_Email_Address, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Customer_Email_Address))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Cost_Price',
    COUNT(*),
    SUM(CASE WHEN Cost_Price IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Cost_Price, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Cost_Price))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Sale_Price',
    COUNT(*),
    SUM(CASE WHEN Sale_Price IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Sale_Price, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Sale_Price))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Discount_Amount',
    COUNT(*),
    SUM(CASE WHEN Discount_Amount IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Discount_Amount, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Discount_Amount))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Finance_Amount',
    COUNT(*),
    SUM(CASE WHEN Finance_Amount IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Finance_Amount, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Finance_Amount))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'PC_Market_Price',
    COUNT(*),
    SUM(CASE WHEN PC_Market_Price IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(PC_Market_Price, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(PC_Market_Price))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Storage_Capacity',
    COUNT(*),
    SUM(CASE WHEN Storage_Capacity IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Storage_Capacity, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Storage_Capacity))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Storage_Type',
    COUNT(*),
    SUM(CASE WHEN Storage_Type IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Storage_Type, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Storage_Type))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'RAM',
    COUNT(*),
    SUM(CASE WHEN RAM IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(RAM, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(RAM))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'PC_Make',
    COUNT(*),
    SUM(CASE WHEN PC_Make IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(PC_Make, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(PC_Make))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'PC_Model',
    COUNT(*),
    SUM(CASE WHEN PC_Model IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(PC_Model, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(PC_Model))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Sales_Person_Name',
    COUNT(*),
    SUM(CASE WHEN Sales_Person_Name IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Sales_Person_Name, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Sales_Person_Name))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Credit_Score',
    COUNT(*),
    SUM(CASE WHEN Credit_Score IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Credit_Score, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Credit_Score))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Sales_Person_Department',
    COUNT(*),
    SUM(CASE WHEN Sales_Person_Department IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Sales_Person_Department, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Sales_Person_Department))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Cost_of_Repairs',
    COUNT(*),
    SUM(CASE WHEN Cost_of_Repairs IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Cost_of_Repairs, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Cost_of_Repairs))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Channel',
    COUNT(*),
    SUM(CASE WHEN Channel IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Channel, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Channel))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Total_Sales_per_Employee',
    COUNT(*),
    SUM(CASE WHEN Total_Sales_per_Employee IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Total_Sales_per_Employee, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Total_Sales_per_Employee))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Priority',
    COUNT(*),
    SUM(CASE WHEN Priority IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Priority, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Priority))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Payment_Method',
    COUNT(*),
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Payment_Method, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Payment_Method))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Purchase_Date',
    COUNT(*),
    SUM(CASE WHEN Purchase_Date IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Purchase_Date, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Purchase_Date))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

UNION ALL

SELECT 
    'Ship_Date',
    COUNT(*),
    SUM(CASE WHEN Ship_Date IS NULL THEN 1 ELSE 0 END),
    SUM(CASE WHEN LTRIM(RTRIM(ISNULL(Ship_Date, ''))) = '' THEN 1 ELSE 0 END),
    SUM(CASE WHEN UPPER(LTRIM(RTRIM(Ship_Date))) IN ('N/A','NA','NULL','NONE','?','-','UNKNOWN') THEN 1 ELSE 0 END)
FROM dbo.stg_pc_data

ORDER BY ColumnName;


SELECT 'Cost_Price' AS ColumnName,
       COUNT(*) AS InvalidValues
FROM dbo.stg_pc_data
WHERE TRY_CONVERT(decimal(18,2), Cost_Price) IS NULL
  AND Cost_Price IS NOT NULL

UNION ALL

SELECT 'Sale_Price',
       COUNT(*)
FROM dbo.stg_pc_data
WHERE TRY_CONVERT(decimal(18,2), Sale_Price) IS NULL
  AND Sale_Price IS NOT NULL

UNION ALL

SELECT 'Discount_Amount',
       COUNT(*)
FROM dbo.stg_pc_data
WHERE TRY_CONVERT(decimal(18,2), Discount_Amount) IS NULL
  AND Discount_Amount IS NOT NULL

UNION ALL

SELECT 'Finance_Amount',
       COUNT(*)
FROM dbo.stg_pc_data
WHERE TRY_CONVERT(decimal(18,2), Finance_Amount) IS NULL
  AND Finance_Amount IS NOT NULL

UNION ALL

SELECT 'PC_Market_Price',
       COUNT(*)
FROM dbo.stg_pc_data
WHERE TRY_CONVERT(decimal(18,2), PC_Market_Price) IS NULL
  AND PC_Market_Price IS NOT NULL

UNION ALL

SELECT 'Cost_of_Repairs',
       COUNT(*)
FROM dbo.stg_pc_data
WHERE TRY_CONVERT(decimal(18,2), Cost_of_Repairs) IS NULL
  AND Cost_of_Repairs IS NOT NULL

UNION ALL

SELECT 'Credit_Score',
       COUNT(*)
FROM dbo.stg_pc_data
WHERE TRY_CONVERT(int, Credit_Score) IS NULL
  AND Credit_Score IS NOT NULL

UNION ALL

SELECT 'Total_Sales_per_Employee',
       COUNT(*)
FROM dbo.stg_pc_data
WHERE TRY_CONVERT(decimal(18,2), Total_Sales_per_Employee) IS NULL
  AND Total_Sales_per_Employee IS NOT NULL

ORDER BY ColumnName;




/*=========================================================
    CLEAN CURRENT DATA
=========================================================*/

BEGIN TRANSACTION;

----------------------------------------------------------
-- 1. Remove the CSV header row
----------------------------------------------------------
DELETE
FROM dbo.stg_pc_data
WHERE Continent = 'Continent';


----------------------------------------------------------
-- 2. Standardize blank strings to NULL
----------------------------------------------------------
UPDATE dbo.stg_pc_data
SET
    Continent                  = NULLIF(LTRIM(RTRIM(Continent)), ''),
    Country_or_State           = NULLIF(LTRIM(RTRIM(Country_or_State)), ''),
    Province_or_City           = NULLIF(LTRIM(RTRIM(Province_or_City)), ''),
    Shop_Name                  = NULLIF(LTRIM(RTRIM(Shop_Name)), ''),
    Customer_Name              = NULLIF(LTRIM(RTRIM(Customer_Name)), ''),
    Customer_Surname           = NULLIF(LTRIM(RTRIM(Customer_Surname)), ''),
    Customer_Contact_Number    = NULLIF(LTRIM(RTRIM(Customer_Contact_Number)), ''),
    Customer_Email_Address     = NULLIF(LTRIM(RTRIM(Customer_Email_Address)), ''),
    Storage_Type               = NULLIF(LTRIM(RTRIM(Storage_Type)), ''),
    PC_Make                    = NULLIF(LTRIM(RTRIM(PC_Make)), ''),
    PC_Model                   = NULLIF(LTRIM(RTRIM(PC_Model)), ''),
    Sales_Person_Name          = NULLIF(LTRIM(RTRIM(Sales_Person_Name)), ''),
    Sales_Person_Department    = NULLIF(LTRIM(RTRIM(Sales_Person_Department)), ''),
    Channel                    = NULLIF(LTRIM(RTRIM(Channel)), ''),
    Priority                   = NULLIF(LTRIM(RTRIM(Priority)), ''),
    Payment_Method             = NULLIF(LTRIM(RTRIM(Payment_Method)), '');


----------------------------------------------------------
-- 3. Standardize phone numbers
----------------------------------------------------------
UPDATE dbo.stg_pc_data
SET Customer_Contact_Number =
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(Customer_Contact_Number,'(', ''),
            ')',''),
        '-',''),
    ' ','')
WHERE Customer_Contact_Number IS NOT NULL;


----------------------------------------------------------
-- 4. Flag impossible dates
----------------------------------------------------------
UPDATE dbo.stg_pc_data
SET Ship_Date = NULL
WHERE Ship_Date < Purchase_Date;


----------------------------------------------------------
-- 5. Replace invalid email addresses with NULL
----------------------------------------------------------
UPDATE dbo.stg_pc_data
SET Customer_Email_Address = NULL
WHERE Customer_Email_Address NOT LIKE '%_@_%._%';


----------------------------------------------------------
-- 6. Replace invalid credit scores
----------------------------------------------------------
--UPDATE dbo.stg_pc_data
--SET Credit_Score = NULL
--WHERE Credit_Score < 0
--OR Credit_Score > 850;


----------------------------------------------------------
-- 7. Replace negative monetary values with NULL
----------------------------------------------------------
SELECT *
FROM [dbo].[stg_pc_data]  -- or whichever layer you're checking
WHERE Customer_Surname IS NOT NULL
AND TRY_CONVERT(int, Customer_Surname) IS NOT NULL;  -- surname parses as a number = wrong


SELECT *
FROM [dbo].[stg_pc_data]
WHERE TRY_CONVERT(int, Customer_Surname) IS NOT NULL
  AND Customer_Contact_Number LIKE '%[a-zA-Z]%'
  AND Customer_Email_Address IS NULL;




  -- Log them to a review table, same pattern as your other project
IF OBJECT_ID(N'dbo.DataQuality_B2BCustomerRows', N'U') IS NOT NULL
    DROP TABLE dbo.DataQuality_B2BCustomerRows;
GO
CREATE TABLE dbo.DataQuality_B2BCustomerRows (
    FlagID INT IDENTITY(1,1) PRIMARY KEY,
    OriginalRow NVARCHAR(MAX),
    FlaggedDate DATETIME DEFAULT GETDATE()
);
GO
INSERT INTO dbo.DataQuality_B2BCustomerRows (OriginalRow)
SELECT CONCAT(Customer_Name, ' | ', Customer_Surname, ' | ', Customer_Contact_Number, ' | ', Customer_Email_Address)
FROM [dbo].[stg_pc_data]
WHERE TRY_CONVERT(int, Customer_Surname) IS NOT NULL
   OR Customer_Contact_Number LIKE '%[a-zA-Z]%';
GO



IF OBJECT_ID(N'dbo.DataQuality_InvalidPaymentMethod', N'U') IS NOT NULL
    DROP TABLE dbo.DataQuality_InvalidPaymentMethod;
GO
CREATE TABLE dbo.DataQuality_InvalidPaymentMethod (
    FlagID INT IDENTITY(1,1) PRIMARY KEY,
    SalesKey INT,
    Payment_Method NVARCHAR(50),
    FlaggedDate DATETIME DEFAULT GETDATE()
);
GO
INSERT INTO dbo.DataQuality_InvalidPaymentMethod (SalesKey, Payment_Method)
SELECT SalesKey, Payment_Method
FROM [dbo].[stg_pc_data]
WHERE TRY_CONVERT(int, Payment_Method) IS NOT NULL;
GO




FROM dbo.stg_pc_data
WHERE NOT (
    TRY_CONVERT(date, Ship_Date, 101) IS NOT NULL
    AND TRY_CONVERT(date, Purchase_Date, 101) IS NOT NULL
    AND TRY_CONVERT(date, Ship_Date, 101) < TRY_CONVERT(date, Purchase_Date, 101)
);
GO


-- Flag definitively broken rows (ship before purchase — logically impossible)
IF OBJECT_ID(N'dbo.DataQuality_DateOrderConflicts', N'U') IS NOT NULL
    DROP TABLE dbo.DataQuality_DateOrderConflicts;
GO
CREATE TABLE dbo.DataQuality_DateOrderConflicts (
    FlagID INT IDENTITY(1,1) PRIMARY KEY,
    SalesKey INT,
    Purchase_Date_Raw NVARCHAR(50),
    Ship_Date_Raw NVARCHAR(50),
    FlaggedDate DATETIME DEFAULT GETDATE()
);
GO
INSERT INTO dbo.DataQuality_DateOrderConflicts (SalesKey, Purchase_Date_Raw, Ship_Date_Raw)
SELECT SalesKey, Purchase_Date, Ship_Date
FROM [dbo].[stg_pc_data]
WHERE TRY_CONVERT(date, Ship_Date, 101) < TRY_CONVERT(date, Purchase_Date, 101);
GO



----------------------------------------------------------
-- 8. Verify results
----------------------------------------------------------
SELECT COUNT(*) AS RecordsAfterCleaning
FROM dbo.stg_pc_data;

SELECT *
FROM dbo.stg_pc_data
WHERE Ship_Date < Purchase_Date;

SELECT *
FROM dbo.stg_pc_data
WHERE Customer_Email_Address IS NULL;

SELECT *
FROM dbo.stg_pc_data
WHERE Credit_Score IS NULL;

COMMIT TRANSACTION;



--select  Dynabook from dbo.stg_pc_data where PC_Make = 'Dynabook' and PC_Model = 'Satellite Pro C50-H-1'