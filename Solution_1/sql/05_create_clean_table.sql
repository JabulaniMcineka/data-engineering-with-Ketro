USE PC_Data_DB;
GO


DROP TABLE IF EXISTS dbo.clean_pc_data;
GO

CREATE TABLE dbo.clean_pc_data
(
    SalesKey                    INT IDENTITY(1,1) PRIMARY KEY,

    Continent                   NVARCHAR(50),
    Country_or_State            NVARCHAR(50),
    Province_or_City            NVARCHAR(50),

    Shop_Name                   NVARCHAR(100),
    Shop_Age                    INT,

    Customer_Name               NVARCHAR(50),
    Customer_Surname            NVARCHAR(50),
    Customer_Contact_Number     NVARCHAR(30),
    Customer_Email_Address      NVARCHAR(100),

    Cost_Price                  DECIMAL(18,2),
    Sale_Price                  DECIMAL(18,2),
    Discount_Amount             DECIMAL(18,2),
    Finance_Amount              DECIMAL(18,2),
    PC_Market_Price             DECIMAL(18,2),

    Storage_Capacity            INT,
    Storage_Type                NVARCHAR(50),
    RAM                         INT,

    PC_Make                     NVARCHAR(50),
    PC_Model                    NVARCHAR(100),

    Sales_Person_Name           NVARCHAR(100),
    Credit_Score                INT,
    Sales_Person_Department     NVARCHAR(50),

    Cost_of_Repairs             DECIMAL(18,2),

    Channel                     NVARCHAR(50),
    Total_Sales_per_Employee    DECIMAL(18,2),

    Priority                    NVARCHAR(50),
    Payment_Method              NVARCHAR(50),

    Purchase_Date               DATE,
    Ship_Date                   DATE
);
GO


INSERT INTO dbo.clean_pc_data
(
    Continent,
    Country_or_State,
    Province_or_City,
    Shop_Name,
    Shop_Age,
    Customer_Name,
    Customer_Surname,
    Customer_Contact_Number,
    Customer_Email_Address,
    Cost_Price,
    Sale_Price,
    Discount_Amount,
    Finance_Amount,
    PC_Market_Price,
    Storage_Capacity,
    Storage_Type,
    RAM,
    PC_Make,
    PC_Model,
    Sales_Person_Name,
    Credit_Score,
    Sales_Person_Department,
    Cost_of_Repairs,
    Channel,
    Total_Sales_per_Employee,
    Priority,
    Payment_Method,
    Purchase_Date,
    Ship_Date
)
SELECT
    NULLIF(LTRIM(RTRIM(Continent)), ''),
    NULLIF(LTRIM(RTRIM(Country_or_State)), ''),
    NULLIF(LTRIM(RTRIM(Province_or_City)), ''),

    NULLIF(LTRIM(RTRIM(Shop_Name)), ''),
    TRY_CONVERT(INT, Shop_Age),

    NULLIF(LTRIM(RTRIM(Customer_Name)), ''),
    NULLIF(LTRIM(RTRIM(Customer_Surname)), ''),
    NULLIF(LTRIM(RTRIM(Customer_Contact_Number)), ''),
    NULLIF(LTRIM(RTRIM(Customer_Email_Address)), ''),

    TRY_CONVERT(DECIMAL(18,2), Cost_Price),
    TRY_CONVERT(DECIMAL(18,2), Sale_Price),
    TRY_CONVERT(DECIMAL(18,2), Discount_Amount),
    TRY_CONVERT(DECIMAL(18,2), Finance_Amount),
    TRY_CONVERT(DECIMAL(18,2), PC_Market_Price),

    TRY_CONVERT(INT, Storage_Capacity),
    NULLIF(LTRIM(RTRIM(Storage_Type)), ''),
    TRY_CONVERT(INT, RAM),

    NULLIF(LTRIM(RTRIM(PC_Make)), ''),
    NULLIF(LTRIM(RTRIM(PC_Model)), ''),

    NULLIF(LTRIM(RTRIM(Sales_Person_Name)), ''),
    TRY_CONVERT(INT, Credit_Score),
    NULLIF(LTRIM(RTRIM(Sales_Person_Department)), ''),

    TRY_CONVERT(DECIMAL(18,2), Cost_of_Repairs),

    NULLIF(LTRIM(RTRIM(Channel)), ''),
    TRY_CONVERT(DECIMAL(18,2), Total_Sales_per_Employee),

    NULLIF(LTRIM(RTRIM(Priority)), ''),
    NULLIF(LTRIM(RTRIM(Payment_Method)), ''),

    TRY_CONVERT(date, Purchase_Date, 101) AS Purchase_Date,
    TRY_CONVERT(date, Ship_Date, 101) AS Ship_Date

FROM dbo.stg_pc_data;
GO

-- Verify
SELECT COUNT(*) AS staging_row_count FROM dbo.clean_pc_data;
SELECT TOP (5) * FROM dbo.clean_pc_data;
GO