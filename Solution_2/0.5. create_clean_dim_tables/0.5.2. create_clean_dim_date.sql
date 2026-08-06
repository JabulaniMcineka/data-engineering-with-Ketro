USE clean_express_db;
GO

IF OBJECT_ID(N'[clean_express_db].[dbo].[clean_dim_date]', N'U') IS NULL
BEGIN
    CREATE TABLE [clean_express_db].[dbo].[clean_dim_date]
    (
        date_key        INT,
        full_date       DATE,
        day_number      TINYINT,
        day_name        VARCHAR(20),
        month_number    TINYINT,
        month_name      VARCHAR(20),
        quarter_number  TINYINT,
        year_number     SMALLINT,
        week_number     TINYINT,
        day_of_week     TINYINT
    );
END;
GO

select * from clean_express_db.dbo.clean_dim_date