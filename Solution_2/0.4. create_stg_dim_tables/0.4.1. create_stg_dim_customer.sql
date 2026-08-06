use stg_express_db;
GO  


SELECT [customer_first_name]
      ,[customer_last_name]
      ,[customer_email]
      ,[customer_phone]
      ,[customer_city]
      ,[customer_province]
      ,[customer_loyalty_tier]
      ,[customer_since]
FROM [stg_express_db].[dbo].[stg_express_data]


DROP TABLE IF EXISTS [stg_express_db].[dbo].[stg_dim_customer]

USE stg_express_db;
GO


IF OBJECT_ID(N'[stg_express_db].[dbo].[stg_dim_customer]', N'U') IS NULL
CREATE TABLE [stg_express_db].[dbo].[stg_dim_customer] (
       [customer_id] INT IDENTITY(1,1) PRIMARY KEY,   
       [customer_first_name] VARCHAR(255),
       [customer_last_name] VARCHAR(255),
       [customer_email] VARCHAR(255),
       [customer_phone] INT,                         
       [customer_city] VARCHAR(255),
       [customer_province] VARCHAR(255),
       [customer_loyalty_tier] VARCHAR(255),
       [customer_since] DATETIME2
       );



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



SELECT * FROM [stg_express_db].[dbo].[stg_dim_customer]