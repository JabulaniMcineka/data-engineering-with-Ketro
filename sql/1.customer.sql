/*
=======================================================
Script: 1.dim_customer.sql
Description: Creates and populates dim_customer dimension table
Purpose: Store customer demographic information
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-26
=======================================================
*/

-- Drop and recreate if exists
IF OBJECT_ID('[PC_Sales_Staging_dtw].[dbo].[dim_customer]', 'U') IS NOT NULL
    DROP TABLE [PC_Sales_Staging_dtw].[dbo].[dim_customer];

CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_customer] (
    [Customer_Key]   INT IDENTITY(1,1) PRIMARY KEY,
    [First_Name]     NVARCHAR(50)  NOT NULL,
    [Last_Name]      NVARCHAR(50)  NOT NULL,
    [Contact_Number] NVARCHAR(50)  NOT NULL,
    [Email_Address]  NVARCHAR(100) NOT NULL,
    [Credit_Score]   NVARCHAR(50)  NOT NULL,
    [Priority]       NVARCHAR(50)  NOT NULL
);

-- Insert distinct customer records from staging
INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_customer] (
    [First_Name],
    [Last_Name],
    [Contact_Number],
    [Email_Address],
    [Credit_Score],
    [Priority]
)
SELECT DISTINCT
    [Customer_Name],
    [Customer_Surname],
    [Customer_Contact_Number],
    [Customer_Email_Address],
    [Credit_Score],
    [Priority]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];

-- Verification
SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_customer];