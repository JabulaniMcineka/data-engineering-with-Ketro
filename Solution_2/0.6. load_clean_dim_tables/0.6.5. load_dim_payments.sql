use clean_express_db;

INSERT INTO [clean_express_db].[dbo].[clean_dim_payment]
(
    payment_method
)
SELECT DISTINCT
    UPPER(LTRIM(RTRIM(payment_method)))
FROM [stg_express_db].[dbo].[stg_dim_payment] S
WHERE payment_method IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM [clean_express_db].[dbo].[clean_dim_payment] D
    WHERE D.payment_method = UPPER(LTRIM(RTRIM(S.payment_method)))
);
GO

---------------------------------------------------------------------------

SELECT * FROM [clean_express_db].[dbo].[clean_dim_payment]