-- Create the database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'PC_Data_DB')
BEGIN
    CREATE DATABASE PC_Data_DB;
END;
GO

USE PC_Data_DB;
GO