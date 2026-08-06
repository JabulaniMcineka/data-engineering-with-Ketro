USE dwh_express_db;
GO

IF OBJECT_ID(N'[dwh_express_db].[dbo].[dwh_dim_product]', N'U') IS NULL
BEGIN

    CREATE TABLE [dwh_express_db].[dbo].[dwh_dim_product]
    (
        product_key INT IDENTITY(1,1) PRIMARY KEY,

        product_name VARCHAR(255),
        category VARCHAR(255),
        sub_category VARCHAR(255),
        sku VARCHAR(255),
        supplier VARCHAR(255)
    );

END;
GO