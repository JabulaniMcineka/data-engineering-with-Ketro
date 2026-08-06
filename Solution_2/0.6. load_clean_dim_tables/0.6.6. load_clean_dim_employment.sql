INSERT INTO [clean_express_db].[dbo].[clean_dim_employment]
(
    cashier_name
)
SELECT DISTINCT
    UPPER(LTRIM(RTRIM(cashier_name)))
FROM [stg_express_db].[dbo].[stg_dim_employment] S
WHERE cashier_name IS NOT NULL
AND NOT EXISTS
(
    SELECT 1
    FROM [clean_express_db].[dbo].[clean_dim_employment] D
    WHERE D.cashier_name = UPPER(LTRIM(RTRIM(S.cashier_name)))
);
GO

----------------------------------------------------------------------------

SELECT * FROM [clean_express_db].[dbo].[clean_dim_employment]