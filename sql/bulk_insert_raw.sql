DROP TABLE IF EXISTS [PC_Sales_Staging_dtw].[dbo].[pc_data];

CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[pc_data] (
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

BULK INSERT [PC_Sales_Staging_dtw].[dbo].[pc_data]
FROM 'C:\temp\pc_data.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);

SELECT TOP 5 * FROM [PC_Sales_Staging_dtw].[dbo].[pc_data];