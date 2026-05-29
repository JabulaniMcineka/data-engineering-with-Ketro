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