USE dwh_express_db;
GO

INSERT INTO [dwh_express_db].[dbo].[dwh_dim_payment]
(
    payment_method
)

SELECT

    C.payment_method

FROM [clean_express_db].[dbo].[clean_dim_payment] C

WHERE NOT EXISTS
(
    SELECT 1

    FROM [dwh_express_db].[dbo].[dwh_dim_payment] D

    WHERE D.payment_method = C.payment_method
);
GO

-----------------------------------------------------------------------------------

SELECT * FROM [dwh_express_db].[dbo].[dwh_dim_payment]