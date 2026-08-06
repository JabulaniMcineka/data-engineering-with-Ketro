Use stg_express_db
GO

SELECT [cashier_name]
FROM [stg_express_db].[dbo].[stg_express_data]

-----------------------------------------------------------------------

USE stg_express_db;
GO


IF OBJECT_ID(N'[stg_express_db].[dbo].[stg_dim_employment]', N'U') IS NULL
CREATE TABLE [stg_express_db].[dbo].[stg_dim_employment] (
       [employment_id] INT IDENTITY(1, 1) PRIMARY KEY,
       [cashier_name] VARCHAR(255),

       );
----------------------------------------------------------------------------------

INSERT INTO [stg_express_db].[dbo].[stg_dim_employment] (
     [cashier_name]

)

SELECT DISTINCT    [cashier_name]
FROM [stg_express_db].[dbo].[stg_express_data]

-----------------------------------------------------------------------------------------

SELECT * FROM [stg_express_db].[dbo].[stg_dim_employment]