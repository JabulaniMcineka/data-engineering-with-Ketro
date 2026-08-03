IF NOT EXISTS(SELECT name FROM sys.databases WHERE name = 'stg_express_db')
BEGIN
        CREATE DATABASE stg_express_db;
END