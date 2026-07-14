/*
=======================================================
Script: 04_create_dim_shop.sql
Description: Refreshes and populates the dim_shop table
Purpose: Store shop and location information in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

USE [PC_Sales_Staging_dtw];
GO

-- Ensure the target table exists before loading
IF OBJECT_ID(N'[dbo].[stg_dim_shop]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[stg_dim_shop] (
        [Shop_Key]      INT IDENTITY(1, 1) PRIMARY KEY,
        [Shop_Name]     NVARCHAR(100) NOT NULL,
        [Shop_Age]      NVARCHAR(30)  NOT NULL,
        [Continent]     NVARCHAR(50)  NOT NULL,
        [Country]       NVARCHAR(50)  NOT NULL,
        [Province_City] NVARCHAR(50)  NOT NULL
    );
END;
GO

-- Clear existing data while preserving the table structure
TRUNCATE TABLE [dbo].[stg_dim_shop];
GO

-- Insert distinct shop records from staging
INSERT INTO [dbo].[stg_dim_shop] (
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
FROM [dbo].[pc_data];
GO

-- Verification
SELECT TOP 10 *
FROM [dbo].[stg_dim_shop];
GO