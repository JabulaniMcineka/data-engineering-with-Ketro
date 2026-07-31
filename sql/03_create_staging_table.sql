USE PC_Data_DB;
GO

-- ============================================
-- Layer 2: Staging — freely truncatable, rebuilt from raw
-- ============================================
IF OBJECT_ID(N'dbo.stg_pc_data', N'U') IS NOT NULL
    DROP TABLE dbo.stg_pc_data;
GO

CREATE TABLE dbo.stg_pc_data (
    stg_id                   INT IDENTITY(1,1) PRIMARY KEY,
    Continent                NVARCHAR(50),
    Country_or_State         NVARCHAR(50),
    Province_or_City         NVARCHAR(50),
    Shop_Name                NVARCHAR(100),
    Shop_Age                 NVARCHAR(50),
    Customer_Name            NVARCHAR(50),
    Customer_Surname         NVARCHAR(50),
    Customer_Contact_Number  NVARCHAR(30),
    Customer_Email_Address   NVARCHAR(100),
    Cost_Price               NVARCHAR(50),
    Sale_Price               NVARCHAR(50),
    Discount_Amount          NVARCHAR(50),
    Finance_Amount           NVARCHAR(50),
    PC_Market_Price          NVARCHAR(50),
    Storage_Capacity         NVARCHAR(50),
    Storage_Type             NVARCHAR(50),
    RAM                      NVARCHAR(50),
    PC_Make                  NVARCHAR(50),
    PC_Model                 NVARCHAR(100),
    Sales_Person_Name        NVARCHAR(100),
    Credit_Score             NVARCHAR(50),
    Sales_Person_Department  NVARCHAR(50),
    Cost_of_Repairs          NVARCHAR(50),
    Channel                  NVARCHAR(50),
    Total_Sales_per_Employee NVARCHAR(50),
    Priority                 NVARCHAR(50),
    Payment_Method           NVARCHAR(50),
    Purchase_Date            NVARCHAR(50),
    Ship_Date                NVARCHAR(50)
);
GO

-- Load staging fresh from raw every time this script runs
INSERT INTO dbo.stg_pc_data (
    Continent, Country_or_State, Province_or_City, Shop_Name, Shop_Age,
    Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address,
    Cost_Price, Sale_Price, Discount_Amount, Finance_Amount, PC_Market_Price,
    Storage_Capacity, Storage_Type, RAM, PC_Make, PC_Model, Sales_Person_Name,
    Credit_Score, Sales_Person_Department, Cost_of_Repairs, Channel,
    Total_Sales_per_Employee, Priority, Payment_Method, Purchase_Date, Ship_Date
)
SELECT
    Continent, Country_or_State, Province_or_City, Shop_Name, Shop_Age,
    Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address,
    Cost_Price, Sale_Price, Discount_Amount, Finance_Amount, PC_Market_Price,
    Storage_Capacity, Storage_Type, RAM, PC_Make, PC_Model, Sales_Person_Name,
    Credit_Score, Sales_Person_Department, Cost_of_Repairs, Channel,
    Total_Sales_per_Employee, Priority, Payment_Method, Purchase_Date, Ship_Date
FROM dbo.raw_pc_data;
GO


--Deleting the first row data which is the header row from the stg_pc_data table
--as it really does not belong to the data set and is just a header row
DELETE FROM [dbo].[stg_pc_data]
WHERE Continent = 'Continent'
   OR Purchase_Date = 'Purchase Date'
   OR Purchase_Date = 'Ship Date'
   OR Ship_Date = 'Ship Date'
   OR Ship_Date = 'Purchase Date';
GO

-- Verify
SELECT COUNT(*) AS staging_row_count FROM dbo.stg_pc_data;
SELECT TOP (5) * FROM dbo.stg_pc_data;
GO