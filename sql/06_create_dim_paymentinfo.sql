/*
=======================================================
Script: 06_create_dim_paymentinfo.sql
Description: Creates and populates the dim_paymentinfo table
Purpose: Store payment-related information in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

-- Drop and recreate the table if it already exists
IF OBJECT_ID('[PC_Sales_Staging_dtw].[dbo].[dim_paymentinfo]', 'U') IS NOT NULL
BEGIN
    DROP TABLE [PC_Sales_Staging_dtw].[dbo].[stg_dim_paymentinfo];
END;
GO

CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[stg_dim_paymentinfo] (
    [Payment_Key]     INT IDENTITY(1, 1) PRIMARY KEY,
    [Payment_Method]  NVARCHAR(50) NOT NULL,
    [Channel]         NVARCHAR(50) NOT NULL,
    [Discount_Amount] NVARCHAR(50) NOT NULL,
    [Finance_Amount]  NVARCHAR(50) NOT NULL
);
GO

-- Insert distinct payment records from staging
INSERT INTO [PC_Sales_Staging_dtw].[dbo].[stg_dim_paymentinfo] (
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
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];
GO

-- Verification
SELECT TOP 10 *
FROM [PC_Sales_Staging_dtw].[dbo].[stg_dim_paymentinfo];
GO