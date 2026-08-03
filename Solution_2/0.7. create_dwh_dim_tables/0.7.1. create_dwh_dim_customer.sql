use stg_express_db;
GO  

-- ============================================
-- Preview raw customer-related columns from the raw data table
-- before staging (sense-check the source data)
-- ============================================
SELECT [customer_first_name]
      ,[customer_last_name]
      ,[customer_email]
      ,[customer_phone]
      ,[customer_city]
      ,[customer_province]
      ,[customer_loyalty_tier]
      ,[customer_since]
FROM [stg_express_db].[dbo].[stg_express_data]
-------------------------------------------------------------------------------------

-- ============================================
-- Rebuild the staging customer dimension table from scratch
-- (drop if it exists, then recreate with the target schema)
-- ============================================
DROP TABLE IF EXISTS [stg_express_db].[dbo].[stg_dim_customer]

USE stg_express_db;
GO

-- Guard against re-creating the table if it somehow already exists
-- (redundant alongside DROP TABLE IF EXISTS above, but harmless)
IF OBJECT_ID(N'[stg_express_db].[dbo].[stg_dim_customer]', N'U') IS NULL
CREATE TABLE [stg_express_db].[dbo].[stg_dim_customer] (
       [customer_id] INT IDENTITY(1,1) PRIMARY KEY,   -- surrogate key for staging
       [customer_first_name] VARCHAR(255),
       [customer_last_name] VARCHAR(255),
       [customer_email] VARCHAR(255),
       [customer_phone] INT,                          -- NOTE: phone numbers stored as INT — risky, see below
       [customer_city] VARCHAR(255),
       [customer_province] VARCHAR(255),
       [customer_loyalty_tier] VARCHAR(255),
       [customer_since] DATETIME2
       );
------------------------------------------------------------------------------------------

-- ============================================
-- Load staging table from raw data, deduplicating exact repeated rows
-- ============================================
INSERT INTO [stg_express_db].[dbo].[stg_dim_customer] (
[customer_first_name],
[customer_last_name],
[customer_email],
[customer_phone],
[customer_city],
[customer_province],
[customer_loyalty_tier],
[customer_since]
)
SELECT DISTINCT [customer_first_name],
                [customer_last_name],
                [customer_email],
                [customer_phone],
                [customer_city],
                [customer_province],
                [customer_loyalty_tier],
                [customer_since]
FROM [stg_express_db].[dbo].[stg_express_data]
-------------------------------------------------------------------------------

-- ============================================
-- Verify the staging load
-- ============================================
SELECT * FROM [stg_express_db].[dbo].[stg_dim_customer]