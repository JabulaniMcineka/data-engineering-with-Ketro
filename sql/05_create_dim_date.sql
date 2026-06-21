/*
=======================================================
Script: 05_create_dim_date.sql
Description: Creates and populates the dim_date table
Purpose: Store date-related information in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

-- Drop and recreate the table if it already exists
IF OBJECT_ID('[PC_Sales_Staging_dtw].[dbo].[dim_date]', 'U') IS NOT NULL
BEGIN
    DROP TABLE [PC_Sales_Staging_dtw].[dbo].[stg_dim_date];
END;
GO

CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[stg_dim_date] (
    [Date_Key]   INT IDENTITY(1, 1) PRIMARY KEY,
    [Full_Date]  DATE         NOT NULL,
    [Day]        INT          NOT NULL,
    [Month]      INT          NOT NULL,
    [Month_Name] NVARCHAR(20) NOT NULL,
    [Quarter]    INT          NOT NULL,
    [Year]       INT          NOT NULL,
    [Day_Name]   NVARCHAR(20) NOT NULL,
    [Is_Weekend] NVARCHAR(10) NOT NULL
);
GO

-- Insert distinct dates from staging
INSERT INTO [PC_Sales_Staging_dtw].[dbo].[stg_dim_date] (
    [Full_Date],
    [Day],
    [Month],
    [Month_Name],
    [Quarter],
    [Year],
    [Day_Name],
    [Is_Weekend]
)
SELECT DISTINCT
    d.[Full_Date],
    DAY(d.[Full_Date]),
    MONTH(d.[Full_Date]),
    DATENAME(MONTH, d.[Full_Date]),
    DATEPART(QUARTER, d.[Full_Date]),
    YEAR(d.[Full_Date]),
    DATENAME(WEEKDAY, d.[Full_Date]),
    CASE
        WHEN DATENAME(WEEKDAY, d.[Full_Date]) IN ('Saturday', 'Sunday')
            THEN 'Yes'
        ELSE 'No'
    END
FROM (
    SELECT TRY_CAST([Ship_Date] AS DATE) AS [Full_Date]
    FROM [PC_Sales_Staging_dtw].[dbo].[pc_data]
    WHERE [Ship_Date] IS NOT NULL
      AND [Ship_Date] <> 'N/A'
) AS d
WHERE d.[Full_Date] IS NOT NULL;
GO

-- Verification
SELECT TOP 10 *
FROM [PC_Sales_Staging_dtw].[dbo].[stg_dim_date];
GO
