IF NOT EXISTS(SELECT name FROM sys.databases WHERE name = 'dwh_express_db')
BEGIN
        CREATE DATABASE dwh_express_db;
END