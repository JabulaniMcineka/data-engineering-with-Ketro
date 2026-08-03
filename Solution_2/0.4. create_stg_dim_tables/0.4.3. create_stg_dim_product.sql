Use stg_express_db;
GO

SELECT [product_name],
       [category],
       [sub_category],
       [sku],
       [supplier]
FROM [stg_express_db].[dbo].[stg_express_data]

  ----------------------------------------------------------------------------------

DROP TABLE IF EXISTS [stg_express_db   ].[dbo].[stg_dim_product]

USE stg_express_db;
GO


IF OBJECT_ID(N'[stg_express_db].[dbo].[stg_dim_product]', N'U') IS NULL
CREATE TABLE [stg_express_db].[dbo].[stg_dim_product] (
       [product_id] INT IDENTITY(1, 1) PRIMARY KEY,
       [product_name] VARCHAR(255),
       [category] VARCHAR(255),
       [sub_category] VARCHAR(255),
       [sku] VARCHAR(255),
       [supplier] VARCHAR(255)

       );

---------------------------------------------------------------------------------------

INSERT INTO [stg_express_db].[dbo].[stg_dim_product] (
       [product_name],
       [category],
       [sub_category],
       [sku],
       [supplier]

)

SELECT DISTINCT [product_name],
                [category],
                [sub_category],
                [sku],
                [supplier]
FROM [stg_express_db].[dbo].[stg_express_data]

---------------------------------------------------------------------------------

    SELECT * FROM [stg_express_db].[dbo].[stg_dim_product]