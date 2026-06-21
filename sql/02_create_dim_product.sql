/*
=======================================================
Script: 02_create_dim_product.sql
Description: Creates and populates the dim_product table
Purpose: Store product-related information in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

-- Drop and recreate the table if it already exists
IF OBJECT_ID('[PC_Sales_Staging_dtw].[dbo].[dim_product]', 'U') IS NOT NULL
BEGIN
    DROP TABLE [PC_Sales_Staging_dtw].[dbo].[stg_dim_product];
END;
GO

CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[stg_dim_product] (
    [Product_Key]      INT IDENTITY(1, 1) PRIMARY KEY,
    [PC_Name]          NVARCHAR(100) NOT NULL,
    [PC_Make]          NVARCHAR(50)  NOT NULL,
    [PC_Model]         NVARCHAR(100) NOT NULL,
    [Storage_Capacity] NVARCHAR(50)  NOT NULL,
    [RAM]              NVARCHAR(20)  NOT NULL,
    [PC_Market_Price]  NVARCHAR(20)  NOT NULL,
    [Storage_Type]     NVARCHAR(20)  NOT NULL,
    [Cost_of_Repair]   NVARCHAR(20)  NOT NULL
);
GO

-- Insert distinct product records from staging
INSERT INTO [PC_Sales_Staging_dtw].[dbo].[stg_dim_product] (
    [PC_Name],
    [PC_Make],
    [PC_Model],
    [Storage_Capacity],
    [RAM],
    [PC_Market_Price],
    [Storage_Type],
    [Cost_of_Repair]
)
SELECT DISTINCT
    CONCAT([PC_Make], ' ', [PC_Model]) AS [PC_Name],
    [PC_Make],
    [PC_Model],
    [Storage_Capacity],
    [RAM],
    [PC_Market_Price],
    [Storage_Type],
    [Cost_of_Repairs]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];
GO

-- Verification
SELECT TOP 10 *
FROM [PC_Sales_Staging_dtw].[dbo].[stg_dim_product];
GO