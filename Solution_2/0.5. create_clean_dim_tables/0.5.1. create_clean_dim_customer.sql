USE clean_express_db;
GO



IF OBJECT_ID(N'[clean_express_db].[dbo].[clean_dim_customer]', N'U') IS NULL
BEGIN
    CREATE TABLE [clean_express_db].[dbo].[clean_dim_customer]
    (
        customer_first_name      VARCHAR(255),
        customer_last_name       VARCHAR(255),
        customer_email           VARCHAR(255),
        customer_phone           VARCHAR(50),
        customer_city            VARCHAR(255),
        customer_province        VARCHAR(255),
        customer_loyalty_tier    VARCHAR(100),
        customer_since           DATETIME2
    );
END;
GO

select * from clean_express_db.dbo.clean_dim_customer