/*
=======================================================
Script: 03_create_dim_salesperson.sql
Description: Creates and populates the dim_salesperson table
Purpose: Store sales employee information in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

-- Drop and recreate the table if it already exists
IF OBJECT_ID('[PC_Sales_Staging_dtw].[dbo].[dim_salesperson]', 'U') IS NOT NULL
BEGIN
    DROP TABLE [PC_Sales_Staging_dtw].[dbo].[dim_salesperson];
END;
GO

CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[stg_dim_salesperson] (
    [Salesperson_Key] INT IDENTITY(1, 1) PRIMARY KEY,
    [Employee_Sales]  NVARCHAR(100) NOT NULL,
    [Department]      NVARCHAR(50)  NOT NULL,
    [Total_Sales]     NVARCHAR(50)  NOT NULL
);
GO

-- Insert distinct salesperson records from staging
INSERT INTO [PC_Sales_Staging_dtw].[dbo].[stg_dim_salesperson] (
    [Employee_Sales],
    [Department],
    [Total_Sales]
)
SELECT DISTINCT
    [Sales_Person_Name],
    [Sales_Person_Department],
    [Total_Sales_per_Employee]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];
GO

-- Verification
SELECT TOP 10 *
FROM [PC_Sales_Staging_dtw].[dbo].[stg_dim_salesperson];
GO