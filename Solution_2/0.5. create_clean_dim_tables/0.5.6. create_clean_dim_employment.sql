USE clean_express_db;
GO

IF OBJECT_ID(N'[clean_express_db].[dbo].[clean_dim_employment]', N'U') IS NULL
BEGIN
    CREATE TABLE [clean_express_db].[dbo].[clean_dim_employment]
    (
        cashier_name VARCHAR(255)
    );
END;
GO

select * from clean_express_db.dbo.clean_dim_employment