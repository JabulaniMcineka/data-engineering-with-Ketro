/*
=======================================================
Script: 1.dim_customer.sql
Description: Creates and populates dim_customer dimension table
Purpose: Store customer demographic information
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-26
=======================================================
*/

CREATE TABLE IF NOT EXISTS [PC_Sales_Staging_dtw].[dbo].[dim_customer](
    [Customer_ID] int identity (1, 1) primary key,
    [Customer_Name] [nvarchar](50) NOT NULL,
    [Customer_Surname] [nvarchar](50) NOT NULL,
    [Customer_Contact_Number] [nvarchar](50) NOT NULL,
    [Customer_Email_Address] [nvarchar](50) NOT NULL,
    [Sales_Person_Name] [nvarchar](50) NOT NULL,
    [Sales_Person_Department] [nvarchar](50) NOT NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
)

-- Insert distinct customer records from raw data
-- Load unique customers into dimension table
INSERT INTO
    [PC_Sales_Staging_dtw].[dbo].[dim_customer](
        [Customer_Name],
        [Customer_Surname],
        [Customer_Contact_Number],
        [Customer_Email_Address],
        [Sales_Person_Name],
        [Sales_Person_Department]
    )
SELECT
    DISTINCT [Customer_Name],
    [Customer_Surname],
    [Customer_Contact_Number],
    [Customer_Email_Address],
    [Sales_Person_Name],
    [Sales_Person_Department]
FROM
    [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

-- Verification Query: Display loaded customer dimension records
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_customer] 