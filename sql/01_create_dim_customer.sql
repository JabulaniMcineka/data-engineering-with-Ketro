/*
=======================================================
Script: 01_create_dim_customer.sql
Description: Refreshes and populates the dim_customer dimension table
Purpose: Store customer demographic information in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-26
=======================================================
*/

USE [PC_Sales_Staging_dtw];
GO

-- Ensure the target table exists before loading
IF OBJECT_ID(N'[dbo].[stg_dim_customer]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[stg_dim_customer] (
        [Customer_Key]   INT IDENTITY(1, 1) PRIMARY KEY,
        [First_Name]     NVARCHAR(50)  NOT NULL,
        [Last_Name]      NVARCHAR(50)  NOT NULL,
        [Contact_Number] NVARCHAR(50)  NOT NULL,
        [Email_Address]  NVARCHAR(100) NOT NULL,
        [Credit_Score]   NVARCHAR(50)  NOT NULL,
        [Priority]       NVARCHAR(50)  NOT NULL
    );
END;
GO

-- Clear existing data while preserving the table structure
TRUNCATE TABLE [dbo].[stg_dim_customer];
GO

-- Insert distinct customer records from the raw staging data
INSERT INTO [dbo].[stg_dim_customer] (
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
FROM [dbo].[pc_data];
GO

-- Verification query
SELECT TOP 10 *
FROM [dbo].[stg_dim_customer];
GO