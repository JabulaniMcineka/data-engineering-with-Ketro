/*
=======================================================
Script: 06_create_dim_paymentinfo.sql
Description: Refreshes and populates the dim_paymentinfo table
Purpose: Store payment-related information in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

USE [PC_Sales_Staging_dtw];
GO

-- Ensure the target table exists before loading
IF OBJECT_ID(N'[dbo].[stg_dim_paymentinfo]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[stg_dim_paymentinfo] (
        [Payment_Key]     INT IDENTITY(1, 1) PRIMARY KEY,
        [Payment_Method]  NVARCHAR(50) NOT NULL,
        [Channel]         NVARCHAR(50) NOT NULL,
        [Discount_Amount] NVARCHAR(50) NOT NULL,
        [Finance_Amount]  NVARCHAR(50) NOT NULL
    );
END;
GO

-- Clear existing data while preserving the table structure
TRUNCATE TABLE [dbo].[stg_dim_paymentinfo];
GO

-- Insert distinct payment records from staging
INSERT INTO [dbo].[stg_dim_paymentinfo] (
    [Payment_Method],
    [Channel],
    [Discount_Amount],
    [Finance_Amount]
)
SELECT DISTINCT
    [Payment_Method],
    [Channel],
    [Discount_Amount],
    [Finance_Amount]
FROM [dbo].[pc_data];
GO

-- Verification
SELECT TOP 10 *
FROM [dbo].[stg_dim_paymentinfo];
GO