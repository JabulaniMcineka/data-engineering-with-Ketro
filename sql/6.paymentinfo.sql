/*
=======================================================
Script: 6.dim_paymentinfo.sql
Description: Creates and populates dim_paymentinfo table
Purpose: Store payment-related information
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

-- Drop and recreate if exists
IF OBJECT_ID('[PC_Sales_Staging_dtw].[dbo].[dim_paymentinfo]', 'U') IS NOT NULL
    DROP TABLE [PC_Sales_Staging_dtw].[dbo].[dim_paymentinfo];

CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_paymentinfo] (
    [Payment_Key]       INT IDENTITY(1,1) PRIMARY KEY,
    [Payment_Method]    NVARCHAR(50) NOT NULL,
    [Channel]           NVARCHAR(50) NOT NULL,
    [Discount_Amount]   NVARCHAR(50) NOT NULL,
    [Finance_Amount]    NVARCHAR(50) NOT NULL
);

-- Insert distinct payment records from staging
INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_paymentinfo] (
    [Payment_Method],
    [Channel],
    [Discount_Amount],
    [Finance_Amount]
)
SELECT DISTINCT
    Payment_Method,
    Channel,
    Discount_Amount,
    Finance_Amount
FROM dbo.pc_data;

-- Verification
SELECT TOP 10 *
FROM [PC_Sales_Staging_dtw].[dbo].[dim_paymentinfo];



USE PC_Sales_Staging_dtw;