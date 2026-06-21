/*
=======================================================
Script: 04_create_dim_shop.sql
Description: Creates and populates the dim_shop table
Purpose: Store shop and location information in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

-- Drop and recreate the table if it already exists
IF OBJECT_ID('[PC_Sales_Staging_dtw].[dbo].[stg_dim_shop]', 'U') IS NOT NULL
BEGIN
    DROP TABLE [PC_Sales_Staging_dtw].[dbo].[stg_dim_shop];
END;
GO

CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[stg_dim_shop] (
    [Shop_Key]      INT IDENTITY(1, 1) PRIMARY KEY,
    [Shop_Name]     NVARCHAR(100) NOT NULL,
    [Shop_Age]      NVARCHAR(30)  NOT NULL,
    [Continent]     NVARCHAR(50)  NOT NULL,
    [Country]       NVARCHAR(50)  NOT NULL,
    [Province_City] NVARCHAR(50)  NOT NULL
);
GO

-- Insert distinct shop records from staging
INSERT INTO [PC_Sales_Staging_dtw].[dbo].[stg_dim_shop] (
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
GO

-- Verification
SELECT TOP 10 *
FROM [PC_Sales_Staging_dtw].[dbo].[stg_dim_shop];
GO