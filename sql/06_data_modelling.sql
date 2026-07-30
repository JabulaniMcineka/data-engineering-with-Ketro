USE PC_Data_DB;
GO

-- ============================================
-- Layer 4: Data Modelling — Star Schema
-- Source: dbo.clean_pc_data (must exist and be typed/deduplicated first)
-- ============================================

-- Drop the fact table FIRST — it has FK constraints referencing the dimensions
IF OBJECT_ID(N'dbo.FactPCSales', N'U') IS NOT NULL DROP TABLE [dbo].[FactPCSales];
GO

-- Now dimension tables can be dropped safely
IF OBJECT_ID(N'dbo.DimLocation', N'U') IS NOT NULL DROP TABLE [dbo].[DimLocation];
GO
IF OBJECT_ID(N'dbo.DimShop', N'U') IS NOT NULL DROP TABLE [dbo].[DimShop];
GO
IF OBJECT_ID(N'dbo.DimCustomer', N'U') IS NOT NULL DROP TABLE [dbo].[DimCustomer];
GO
IF OBJECT_ID(N'dbo.DimProduct', N'U') IS NOT NULL DROP TABLE [dbo].[DimProduct];
GO
IF OBJECT_ID(N'dbo.DimSalesPerson', N'U') IS NOT NULL DROP TABLE [dbo].[DimSalesPerson];
GO
IF OBJECT_ID(N'dbo.DimChannel', N'U') IS NOT NULL DROP TABLE [dbo].[DimChannel];
GO
IF OBJECT_ID(N'dbo.DimPriority', N'U') IS NOT NULL DROP TABLE [dbo].[DimPriority];
GO
IF OBJECT_ID(N'dbo.DimPaymentMethod', N'U') IS NOT NULL DROP TABLE [dbo].[DimPaymentMethod];
GO

-- ============================================
-- Dimension: Location
-- ============================================
CREATE TABLE [dbo].[DimLocation](
    [LocationKey] INT IDENTITY(1,1) PRIMARY KEY,
    [Continent] NVARCHAR(50) NULL,
    [Country_or_State] NVARCHAR(50) NULL,
    [Province_or_City] NVARCHAR(50) NULL
);
GO
INSERT INTO [dbo].[DimLocation] (Continent, Country_or_State, Province_or_City)
SELECT DISTINCT Continent, Country_or_State, Province_or_City
FROM [dbo].[clean_pc_data];
GO

-- ============================================
-- Dimension: Shop
-- ============================================
CREATE TABLE [dbo].[DimShop](
    [ShopKey] INT IDENTITY(1,1) PRIMARY KEY,
    [Shop_Name] NVARCHAR(100) NULL,
    [Shop_Age] INT NULL
);
GO
INSERT INTO [dbo].[DimShop] (Shop_Name, Shop_Age)
SELECT DISTINCT Shop_Name, Shop_Age
FROM [dbo].[clean_pc_data];
GO

-- ============================================
-- Dimension: Customer
-- ============================================
CREATE TABLE [dbo].[DimCustomer](
    [CustomerKey] INT IDENTITY(1,1) PRIMARY KEY,
    [Customer_Name] NVARCHAR(50) NULL,
    [Customer_Surname] NVARCHAR(50) NULL,
    [Customer_Contact_Number] NVARCHAR(30) NULL,
    [Customer_Email_Address] NVARCHAR(100) NULL
);
GO
-- Exclude them from DimCustomer going forward
-- (add this WHERE clause to your DimCustomer INSERT in the modeling script)
INSERT INTO [dbo].[DimCustomer] (Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address)
SELECT DISTINCT Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address
FROM [dbo].[clean_pc_data]
WHERE TRY_CONVERT(int, Customer_Surname) IS NULL
  AND Customer_Contact_Number NOT LIKE '%[a-zA-Z]%';
GO




-- ============================================
-- Dimension: Product
-- ============================================
CREATE TABLE [dbo].[DimProduct](
    [ProductKey] INT IDENTITY(1,1) PRIMARY KEY,
    [PC_Make] NVARCHAR(50) NULL,
    [PC_Model] NVARCHAR(100) NULL,
    [Storage_Capacity] INT NULL,
    [Storage_Type] NVARCHAR(50) NULL,
    [RAM] INT NULL
);
GO
INSERT INTO [dbo].[DimProduct] (PC_Make, PC_Model, Storage_Capacity, Storage_Type, RAM)
SELECT DISTINCT PC_Make, PC_Model, Storage_Capacity, Storage_Type, RAM
FROM [dbo].[clean_pc_data];
GO
-- ============================================
-- Dimension: SalesPerson
-- ============================================
CREATE TABLE [dbo].[DimSalesPerson](
    [SalesPersonKey] INT IDENTITY(1,1) PRIMARY KEY,
    [Sales_Person_Name] NVARCHAR(100) NULL,
    [Sales_Person_Department] NVARCHAR(50) NULL
);
GO
INSERT INTO [dbo].[DimSalesPerson] (Sales_Person_Name, Sales_Person_Department)
SELECT DISTINCT Sales_Person_Name, Sales_Person_Department
FROM [dbo].[clean_pc_data];
GO

-- ============================================
-- Dimension: Channel
-- ============================================
CREATE TABLE [dbo].[DimChannel](
    [ChannelKey] INT IDENTITY(1,1) PRIMARY KEY,
    [Channel] NVARCHAR(50) NOT NULL UNIQUE
);
GO
INSERT INTO [dbo].[DimChannel] (Channel)
SELECT DISTINCT Channel
FROM [dbo].[clean_pc_data];
GO

-- ============================================
-- Dimension: Priority
-- ============================================
CREATE TABLE [dbo].[DimPriority](
    [PriorityKey] INT IDENTITY(1,1) PRIMARY KEY,
    [Priority] NVARCHAR(50) NOT NULL UNIQUE
);
GO
INSERT INTO [dbo].[DimPriority] (Priority)
SELECT DISTINCT Priority
FROM [dbo].[clean_pc_data];
GO

-- ============================================
-- Dimension: PaymentMethod
-- ============================================
CREATE TABLE [dbo].[DimPaymentMethod](
    [PaymentMethodKey] INT IDENTITY(1,1) PRIMARY KEY,
    [Payment_Method] NVARCHAR(50) NOT NULL UNIQUE
);
GO
INSERT INTO [dbo].[DimPaymentMethod] (Payment_Method)
SELECT DISTINCT Payment_Method
FROM [dbo].[clean_pc_data]
WHERE TRY_CONVERT(int, Payment_Method) IS NULL;
GO
GO

-- ============================================
-- Fact table
-- ============================================
CREATE TABLE [dbo].[FactPCSales](
    [FactID] INT IDENTITY(1,1) PRIMARY KEY,
    [Purchase_Date] DATE NULL,
    [Ship_Date] DATE NULL,
    [LocationKey] INT NOT NULL REFERENCES [dbo].[DimLocation]([LocationKey]),
    [ShopKey] INT NOT NULL REFERENCES [dbo].[DimShop]([ShopKey]),
    [CustomerKey] INT NOT NULL REFERENCES [dbo].[DimCustomer]([CustomerKey]),
    [ProductKey] INT NOT NULL REFERENCES [dbo].[DimProduct]([ProductKey]),
    [SalesPersonKey] INT NOT NULL REFERENCES [dbo].[DimSalesPerson]([SalesPersonKey]),
    [ChannelKey] INT NOT NULL REFERENCES [dbo].[DimChannel]([ChannelKey]),
    [PriorityKey] INT NOT NULL REFERENCES [dbo].[DimPriority]([PriorityKey]),
    [PaymentMethodKey] INT NOT NULL REFERENCES [dbo].[DimPaymentMethod]([PaymentMethodKey]),
    [Cost_Price] DECIMAL(12,2) NULL,
    [Sale_Price] DECIMAL(12,2) NULL,
    [Discount_Amount] DECIMAL(12,2) NULL,
    [Finance_Amount] DECIMAL(12,2) NULL,
    [PC_Market_Price] DECIMAL(12,2) NULL,
    [Cost_of_Repairs] DECIMAL(12,2) NULL,
    [Total_Sales_per_Employee] DECIMAL(12,2) NULL,
    [Credit_Score] INT NULL
);
GO

-- ============================================
-- Load fact table with dedup via ROW_NUMBER on the natural key
-- ============================================
WITH ranked AS (
    SELECT
        c.Purchase_Date,
        c.Ship_Date,
        dl.LocationKey,
        dsh.ShopKey,
        dc.CustomerKey,
        dp.ProductKey,
        dsp.SalesPersonKey,
        dch.ChannelKey,
        dpr.PriorityKey,
        dpm.PaymentMethodKey,
        c.Cost_Price,
        c.Sale_Price,
        c.Discount_Amount,
        c.Finance_Amount,
        c.PC_Market_Price,
        c.Cost_of_Repairs,
        c.Total_Sales_per_Employee,
        c.Credit_Score,
        ROW_NUMBER() OVER (
            PARTITION BY c.Purchase_Date, c.Ship_Date, dl.LocationKey, dsh.ShopKey,
                         dc.CustomerKey, dp.ProductKey, dsp.SalesPersonKey,
                         dch.ChannelKey, dpr.PriorityKey, dpm.PaymentMethodKey
            ORDER BY c.SalesKey DESC
        ) AS rn
    FROM [dbo].[clean_pc_data] c
    JOIN [dbo].[DimLocation] dl 
        ON  ISNULL(dl.Continent, '') = ISNULL(c.Continent, '')
        AND ISNULL(dl.Country_or_State, '') = ISNULL(c.Country_or_State, '')
        AND ISNULL(dl.Province_or_City, '') = ISNULL(c.Province_or_City, '')
    JOIN [dbo].[DimShop] dsh 
        ON  ISNULL(dsh.Shop_Name, '') = ISNULL(c.Shop_Name, '')
        AND ISNULL(dsh.Shop_Age, -1) = ISNULL(c.Shop_Age, -1)
    JOIN [dbo].[DimCustomer] dc 
        ON  ISNULL(dc.Customer_Name, '') = ISNULL(c.Customer_Name, '')
        AND ISNULL(dc.Customer_Surname, '') = ISNULL(c.Customer_Surname, '')
        AND ISNULL(dc.Customer_Contact_Number, '') = ISNULL(c.Customer_Contact_Number, '')
        AND ISNULL(dc.Customer_Email_Address, '') = ISNULL(c.Customer_Email_Address, '')
    JOIN [dbo].[DimProduct] dp 
        ON  ISNULL(dp.PC_Make, '') = ISNULL(c.PC_Make, '')
        AND ISNULL(dp.PC_Model, '') = ISNULL(c.PC_Model, '')
        AND ISNULL(dp.Storage_Capacity, -1) = ISNULL(c.Storage_Capacity, -1)
        AND ISNULL(dp.Storage_Type, '') = ISNULL(c.Storage_Type, '')
        AND ISNULL(dp.RAM, -1) = ISNULL(c.RAM, -1)
    JOIN [dbo].[DimSalesPerson] dsp 
        ON  ISNULL(dsp.Sales_Person_Name, '') = ISNULL(c.Sales_Person_Name, '')
        AND ISNULL(dsp.Sales_Person_Department, '') = ISNULL(c.Sales_Person_Department, '')
    JOIN [dbo].[DimChannel] dch ON ISNULL(dch.Channel, '') = ISNULL(c.Channel, '')
    JOIN [dbo].[DimPriority] dpr ON ISNULL(dpr.Priority, '') = ISNULL(c.Priority, '')
    JOIN [dbo].[DimPaymentMethod] dpm ON ISNULL(dpm.Payment_Method, '') = ISNULL(c.Payment_Method, '')
        AND TRY_CONVERT(int, c.Payment_Method) IS NULL  -- exclude the 46 numeric bad values
)
INSERT INTO [dbo].[FactPCSales] (
    Purchase_Date, Ship_Date, LocationKey, ShopKey, CustomerKey, ProductKey,
    SalesPersonKey, ChannelKey, PriorityKey, PaymentMethodKey,
    Cost_Price, Sale_Price, Discount_Amount, Finance_Amount, PC_Market_Price,
    Cost_of_Repairs, Total_Sales_per_Employee, Credit_Score
)
SELECT
    Purchase_Date, Ship_Date, LocationKey, ShopKey, CustomerKey, ProductKey,
    SalesPersonKey, ChannelKey, PriorityKey, PaymentMethodKey,
    Cost_Price, Sale_Price, Discount_Amount, Finance_Amount, PC_Market_Price,
    Cost_of_Repairs, Total_Sales_per_Employee, Credit_Score
FROM ranked
WHERE rn = 1;
GO

-- ============================================
-- Sanity checks
-- ============================================
SELECT COUNT(*) AS clean_row_count FROM [dbo].[clean_pc_data];
SELECT COUNT(*) AS fact_row_count FROM [dbo].[FactPCSales];
SELECT TOP 10 * FROM [dbo].[FactPCSales];
GO