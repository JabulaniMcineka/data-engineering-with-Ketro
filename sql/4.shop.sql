/*
=======================================================
Script: 4.dim_shop.sql
Description: Creates and populates dim_shop table
Purpose: Store shop/location information
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

-- Drop and recreate if exists
IF OBJECT_ID('[PC_Sales_Staging_dtw].[dbo].[dim_shop]', 'U') IS NOT NULL
    DROP TABLE [PC_Sales_Staging_dtw].[dbo].[dim_shop];

CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_shop] (
    [Shop_Key]          INT IDENTITY(1,1) PRIMARY KEY,
    [Shop_Name]         NVARCHAR(100) NOT NULL,
    [Shop_Age]          NVARCHAR(30)  NOT NULL,
    [Continent]         NVARCHAR(50)  NOT NULL,
    [Country]           NVARCHAR(50)  NOT NULL,
    [Province_City]     NVARCHAR(50)  NOT NULL
);

-- Insert distinct shop records from staging
INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_shop] (
    [Shop_Name],
    [Shop_Age],
    [Continent],
    [Country],
    [Province_City]
)
SELECT DISTINCT
    [Shop_Name],
    [Shop_Age],
    [Continent],
    [Country_or_State],
    [Province_or_City]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];

-- Verification
SELECT TOP 10 *
FROM [PC_Sales_Staging_dtw].[dbo].[dim_shop];