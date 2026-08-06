USE clean_express_db;
GO

IF OBJECT_ID(N'[clean_express_db].[dbo].[clean_dim_product]', N'U') IS NULL
BEGIN
    CREATE TABLE [clean_express_db].[dbo].[clean_dim_product]
    (
        product_name    VARCHAR(255),
        category        VARCHAR(255),
        sub_category    VARCHAR(255),
        sku             VARCHAR(255),
        supplier        VARCHAR(255)
    );
END;
GO


select * from clean_express_db.dbo.clean_dim_product