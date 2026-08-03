IF NOT EXISTS(SELECT name FROM sys.databases WHERE name = 'clean_express_db')
BEGIN
        CREATE DATABASE clean_express_db;
END