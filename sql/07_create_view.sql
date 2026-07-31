USE PC_Data_DB;
GO

-- ============================================
-- Flat view over the star schema
-- ============================================
IF OBJECT_ID(N'dbo.vw_PCSalesFlat', N'V') IS NOT NULL
    DROP VIEW [dbo].[vw_PCSalesFlat];
GO

CREATE VIEW [dbo].[vw_PCSalesFlat] AS
SELECT
    f.FactID,
    f.Purchase_Date,
    f.Ship_Date,
    dl.Continent,
    dl.Country_or_State,
    dl.Province_or_City,
    dsh.Shop_Name,
    dsh.Shop_Age,
    dc.Customer_Name,
    dc.Customer_Surname,
    dp.PC_Make,
    dp.PC_Model,
    dp.Storage_Capacity,
    dp.Storage_Type,
    dp.RAM,
    dsp.Sales_Person_Name,
    dsp.Sales_Person_Department,
    dch.Channel,
    dpr.Priority,
    dpm.Payment_Method,
    f.Cost_Price,
    f.Sale_Price,
    f.Discount_Amount,
    f.Finance_Amount,
    f.PC_Market_Price,
    f.Cost_of_Repairs,
    f.Total_Sales_per_Employee,
    f.Credit_Score
FROM [dbo].[FactPCSales] f
JOIN [dbo].[DimLocation] dl ON dl.LocationKey = f.LocationKey
JOIN [dbo].[DimShop] dsh ON dsh.ShopKey = f.ShopKey
JOIN [dbo].[DimCustomer] dc ON dc.CustomerKey = f.CustomerKey
JOIN [dbo].[DimProduct] dp ON dp.ProductKey = f.ProductKey
JOIN [dbo].[DimSalesPerson] dsp ON dsp.SalesPersonKey = f.SalesPersonKey
JOIN [dbo].[DimChannel] dch ON dch.ChannelKey = f.ChannelKey
JOIN [dbo].[DimPriority] dpr ON dpr.PriorityKey = f.PriorityKey
JOIN [dbo].[DimPaymentMethod] dpm ON dpm.PaymentMethodKey = f.PaymentMethodKey;
GO

SELECT TOP 10 * FROM [dbo].[vw_PCSalesFlat];
GO