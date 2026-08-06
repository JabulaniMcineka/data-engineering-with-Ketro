
INSERT INTO [clean_express_db].[dbo].[clean_dim_date]
(
    date_key,
    full_date,
    day_number,
    day_name,
    month_number,
    month_name,
    quarter_number,
    year_number,
    week_number,
    day_of_week
)
SELECT
    date_key,
    full_date,
    day_number,
    UPPER(LTRIM(RTRIM(day_name))),
    month_number,
    UPPER(LTRIM(RTRIM(month_name))),
    quarter_number,
    year_number,
    week_number,
    day_of_week
FROM [stg_express_db].[dbo].[stg_dim_date] S
WHERE NOT EXISTS
(
    SELECT 1
    FROM [clean_express_db].[dbo].[clean_dim_date] D
    WHERE D.full_date = S.full_date
);
GO

------------------------------------------------------------------------

SELECT * FROM [clean_express_db].[dbo].[clean_dim_date]