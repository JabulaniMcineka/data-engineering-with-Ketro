USE dwh_express_db;
GO

IF OBJECT_ID(N'[dwh_express_db].[dbo].[dwh_dim_payment]', N'U') IS NULL
BEGIN

    CREATE TABLE [dwh_express_db].[dbo].[dwh_dim_payment]
    (
        payment_key INT IDENTITY(1,1) PRIMARY KEY,

        payment_method VARCHAR(255)
    );

END;
GO