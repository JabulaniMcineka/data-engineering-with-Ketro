/*
=======================================================
Script: 07_create_fact_sales.sql
Description: Creates and populates the fact_sales table
Purpose: Store transactional sales data in the warehouse
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-28
=======================================================
*/

-- Drop and recreate the table if it already exists
DROP TABLE IF EXISTS [PC_Sales_Staging_dtw].[dbo].[dim_fact_sales];
GO

CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_fact_sales] (
    [Sales_Key]       INT IDENTITY(1, 1) PRIMARY KEY,
    [Product_Key]     INT NOT NULL,
    [Customer_Key]    INT NOT NULL,
    [Shop_Key]        INT NOT NULL,
    [Salesperson_Key] INT NOT NULL,
    [Date_Key]        INT NOT NULL,
    [Payment_Key]     INT NOT NULL,
    [Sales_Price]     NVARCHAR(50),
    [Cost_Price]      NVARCHAR(50),
    [Discount_Amount] NVARCHAR(50),
    [Finance_Amount]  NVARCHAR(50)
);
GO

INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_fact_sales] (
    [Product_Key],
    [Customer_Key],
    [Shop_Key],
    [Salesperson_Key],
    [Date_Key],
    [Payment_Key],
    [Sales_Price],
    [Cost_Price],
    [Discount_Amount],
    [Finance_Amount]
)
SELECT
    p.[Product_Key],
    c.[Customer_Key],
    s.[Shop_Key],
    sp.[Salesperson_Key],
    d.[Date_Key],
    pay.[Payment_Key],
    pc.[Sale_Price],
    pc.[Cost_Price],
    pc.[Discount_Amount],
    pc.[Finance_Amount]
FROM [PC_Sales_Staging_dtw].[dbo].[pc_data] AS pc
JOIN [PC_Sales_Staging_dtw].[dbo].[stg_dim_product] AS p
    ON p.[PC_Make] = pc.[PC_Make]
   AND p.[PC_Model] = pc.[PC_Model]
   AND p.[Storage_Type] = pc.[Storage_Type]
   AND p.[RAM] = pc.[RAM]
JOIN [PC_Sales_Staging_dtw].[dbo].[stg_dim_customer] AS c
    ON c.[First_Name] = pc.[Customer_Name]
   AND c.[Last_Name] = pc.[Customer_Surname]
   AND c.[Contact_Number] = pc.[Customer_Contact_Number]
JOIN [PC_Sales_Staging_dtw].[dbo].[stg_dim_shop] AS s
    ON s.[Shop_Name] = pc.[Shop_Name]
   AND s.[Shop_Age] = pc.[Shop_Age]
   AND s.[Continent] = pc.[Continent]
   AND s.[Country] = pc.[Country_or_State]
   AND s.[Province_City] = pc.[Province_or_City]
JOIN [PC_Sales_Staging_dtw].[dbo].[stg_dim_salesperson] AS sp
    ON sp.[Employee_Sales] = pc.[Sales_Person_Name]
   AND sp.[Department] = pc.[Sales_Person_Department]
JOIN [PC_Sales_Staging_dtw].[dbo].[stg_dim_date] AS d
    ON d.[Full_Date] = TRY_CAST(pc.[Purchase_Date] AS DATE)
JOIN [PC_Sales_Staging_dtw].[dbo].[stg_dim_paymentinfo] AS pay
    ON pay.[Payment_Method] = pc.[Payment_Method]
   AND pay.[Channel] = pc.[Channel]
   AND pay.[Discount_Amount] = pc.[Discount_Amount]
   AND pay.[Finance_Amount] = pc.[Finance_Amount];
GO

-- Verification
SELECT TOP 10 *
FROM [PC_Sales_Staging_dtw].[dbo].[dim_fact_sales];
GO