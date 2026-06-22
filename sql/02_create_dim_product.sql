/*
=======================================================
Script: 02_create_dim_product.sql
Description: Refreshes and populates the dim_product table
Purpose: Store product-related information in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

USE [PC_Sales_Staging_dtw];
GO

-- Ensure the target table exists before loading
IF OBJECT_ID(N'[dbo].[stg_dim_product]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[stg_dim_product] (
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
END;
GO

-- Clear existing data while preserving the table structure
TRUNCATE TABLE [dbo].[stg_dim_product];
GO

-- Insert distinct product records from staging
INSERT INTO [dbo].[stg_dim_product] (
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
FROM [dbo].[pc_data];
GO

-- Verification
SELECT TOP 10 *
FROM [dbo].[stg_dim_product];
GO