/*
=======================================================
Script: step1.creating_databases.sql
Description: Creates staging and production databases if they do not exist
Purpose: Initialize the database environment for the ETL pipeline
Author: Data Engineer Jabulani Mcineka
Date: 2026-05-14
=======================================================
*/

-- Create staging database if not present
IF DB_ID('PC_Sales_Staging_dtw') IS NULL
BEGIN
    CREATE DATABASE PC_Sales_Staging_dtw;
END
GO

-- Create production database if not present
IF DB_ID('PC_Sales_Production_dtw') IS NULL
BEGIN
    CREATE DATABASE PC_Sales_Production_dtw;
END
GO


/*
=======================================================
Stored Procedure: sp_create_database
Description: Creates required databases for the solution
Purpose: Initialize staging and data warehouse databases
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_create_database
AS
BEGIN
    SET NOCOUNT ON;

    -- Create Staging Database
    IF DB_ID('PC_Sales_Staging_dtw') IS NULL
    BEGIN
        CREATE DATABASE PC_Sales_Staging_dtw;
        PRINT 'Staging database created successfully.';
    END;

    -- Create Data Warehouse Database
    IF DB_ID('PC_Sales_DWH_dtw') IS NULL
    BEGIN
        CREATE DATABASE PC_Sales_DWH_dtw;
        PRINT 'Data Warehouse database created successfully.';
    END;
END;
GO