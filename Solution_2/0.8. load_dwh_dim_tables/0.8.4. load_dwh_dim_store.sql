use stg_express_db;
GO

SELECT [store_name],
       [store_city],
       [store_province],
       [store_region],
       [store_manager]
FROM [stg_express_db].[dbo].[stg_express_data]

----------------------------------------------------------------------------------

DROP TABLE IF EXISTS [stg_express_db].[dbo].[stg_dim_store]
USE stg_express_db;
GO


IF OBJECT_ID(N'[stg_express_db].[dbo].[stg_dim_store]', N'U') IS NULL
CREATE TABLE [stg_express_db].[dbo].[stg_dim_store] (
       [store_id] INT IDENTITY(1, 1) PRIMARY KEY,
       [store_name] VARCHAR(255),
       [store_city] VARCHAR(255),
       [store_province] VARCHAR(255),
       [store_region] VARCHAR(255),
       [store_manager] VARCHAR(255)

       );

------------------------------------------------------------------------------------------

INSERT INTO [stg_express_db].[dbo].[stg_dim_store] (
       [store_name],
       [store_city],
       [store_province],
       [store_region],
       [store_manager]

)

SELECT DISTINCT    [store_name],
                   [store_city],
                   [store_province],
                   [store_region],
                   [store_manager]
FROM [stg_express_db].[dbo].[stg_express_data]

---------------------------------------------------------------------------------

    SELECT * FROM [stg_express_db].[dbo].[stg_dim_store]