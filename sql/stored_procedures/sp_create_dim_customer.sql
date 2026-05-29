/*
=======================================================
Stored Procedure: sp_create_dim_customer
Description: Creates and populates dim_customer dimension
Purpose: Store customer demographic information
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-36
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_create_dim_customer
AS
BEGIN
    SET NOCOUNT ON;

    -- Dim customer dimension table creation
    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_customer', 'U') IS NULL
    BEGIN
        CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_customer](
            [Customer_ID] int IDENTITY(1,1) PRIMARY KEY,
            [Customer_Name] [nvarchar](50) NOT NULL,
            [Customer_Surname] [nvarchar](50) NOT NULL,
            [Customer_Contact_Number] [nvarchar](50) NOT NULL,
            [Customer_Email_Address] [nvarchar](50) NOT NULL,
            [Sales_Person_Name] [nvarchar](50) NOT NULL,
            [Sales_Person_Department] [nvarchar](50) NOT NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct customer records from raw data, avoid duplicates
    INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_customer](
        [Customer_Name],
        [Customer_Surname],
        [Customer_Contact_Number],
        [Customer_Email_Address],
        [Sales_Person_Name],
        [Sales_Person_Department]
    )
    SELECT DISTINCT
        rd.[Customer_Name],
        rd.[Customer_Surname],
        rd.[Customer_Contact_Number],
        rd.[Customer_Email_Address],
        rd.[Sales_Person_Name],
        rd.[Sales_Person_Department]
    FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] rd
    WHERE NOT EXISTS (
        SELECT 1 FROM [PC_Sales_Staging_dtw].[dbo].[dim_customer] d
        WHERE d.Customer_Name = rd.Customer_Name
          AND d.Customer_Surname = rd.Customer_Surname
          AND d.Customer_Contact_Number = rd.Customer_Contact_Number
          AND d.Customer_Email_Address = rd.Customer_Email_Address
    );

    -- Verification Query: Display loaded customer dimension records
    SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_customer];
END;
GO