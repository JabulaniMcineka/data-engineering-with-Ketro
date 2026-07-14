/*
=======================================================
Script: 03_create_dim_salesperson.sql
Description: Refreshes and populates the dim_salesperson table
Purpose: Store sales employee information in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

USE [PC_Sales_Staging_dtw];
GO

-- Ensure the target table exists before loading
IF OBJECT_ID(N'[dbo].[stg_dim_salesperson]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[stg_dim_salesperson] (
        [Salesperson_Key] INT IDENTITY(1, 1) PRIMARY KEY,
        [Employee_Sales]  NVARCHAR(100) NOT NULL,
        [Department]      NVARCHAR(50)  NOT NULL,
        [Total_Sales]     NVARCHAR(50)  NOT NULL
    );
END;
GO

-- Clear existing data while preserving the table structure
TRUNCATE TABLE [dbo].[stg_dim_salesperson];
GO

-- Insert distinct salesperson records from staging
INSERT INTO [dbo].[stg_dim_salesperson] (
    [Employee_Sales],
    [Department],
    [Total_Sales]
)
SELECT DISTINCT
    [Sales_Person_Name],
    [Sales_Person_Department],
    [Total_Sales_per_Employee]
FROM [dbo].[pc_data];
GO

-- Verification
SELECT TOP 10 *
FROM [dbo].[stg_dim_salesperson];
GO