USE dwh_express_db;
GO

INSERT INTO [dwh_express_db].[dbo].[dwh_dim_employment]
(
    cashier_name
)

SELECT

    C.cashier_name

FROM [clean_express_db].[dbo].[clean_dim_employment] C

WHERE NOT EXISTS
(
    SELECT 1

    FROM [dwh_express_db].[dbo].[dwh_dim_employment] D

    WHERE D.cashier_name = C.cashier_name
);
GO

--------------------------------------------------------------------------

SELECT * FROM [dwh_express_db].[dbo].[dwh_dim_employment]