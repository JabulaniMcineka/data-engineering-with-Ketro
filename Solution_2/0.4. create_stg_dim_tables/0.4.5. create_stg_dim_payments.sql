Use stg_express_db;
GO

SELECT [payment_method]
FROM [stg_express_db].[dbo].[stg_express_data]


-----------------------------------------------------------------------------

USE stg_express_db;
GO


IF OBJECT_ID(N'[stg_express_db].[dbo].[stg_dim_payment]]', N'U') IS NULL
CREATE TABLE [stg_express_db].[dbo].[stg_dim_payment] (
       [payment_id] INT IDENTITY(1, 1) PRIMARY KEY,
       [payment_method] VARCHAR(255),

       );

---------------------------------------------------------------------------------------

INSERT INTO [stg_express_db].[dbo].[stg_dim_payment] (
     [payment_method]

)

SELECT DISTINCT    [payment_method]
FROM [stg_express_db].[dbo].[stg_express_data]

-----------------------------------------------------------------------------------------

SELECT * FROM [stg_express_db].[dbo].[stg_dim_payment]