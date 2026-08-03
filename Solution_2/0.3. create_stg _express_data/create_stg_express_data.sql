USE [stg_express_db];
GO

-- Create the staging table if it doesn't exist
IF OBJECT_ID('[dbo].[stg_express_data]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[stg_express_data]
    (
        [transaction_date] NVARCHAR(50) NOT NULL,
        [payment_method] NVARCHAR(50) NOT NULL,
        [cashier_name] NVARCHAR(50) NOT NULL,
        [transaction_amount] FLOAT NOT NULL,
        [transaction_discount] FLOAT NOT NULL,
        [customer_first_name] NVARCHAR(50) NULL,
        [customer_last_name] NVARCHAR(50) NULL,
        [customer_email] NVARCHAR(50) NULL,
        [customer_phone] INT NULL,
        [customer_city] NVARCHAR(50) NULL,
        [customer_province] NVARCHAR(50) NULL,
        [customer_loyalty_tier] NVARCHAR(50) NULL,
        [customer_since] DATETIME2(7) NULL,
        [store_name] NVARCHAR(50) NOT NULL,
        [store_city] NVARCHAR(50) NOT NULL,
        [store_province] NVARCHAR(50) NOT NULL,
        [store_region] NVARCHAR(50) NOT NULL,
        [store_manager] NVARCHAR(50) NOT NULL,
        [product_name] NVARCHAR(50) NOT NULL,
        [category] NVARCHAR(50) NULL,
        [sub_category] NVARCHAR(50) NOT NULL,
        [sku] NVARCHAR(50) NOT NULL,
        [unit_price] FLOAT NOT NULL,
        [cost_price] FLOAT NOT NULL,
        [supplier] NVARCHAR(50) NOT NULL,
        [qty] NVARCHAR(50) NOT NULL,
        [line_amount] FLOAT NOT NULL,
        [stock_on_hand] INT NOT NULL,
        [reorder_threshold] INT NOT NULL
    );

    PRINT 'stg_express_data table created.';
END
ELSE
BEGIN
    PRINT 'stg_express_data table already exists.';
END;
GO

-- Remove existing data
TRUNCATE TABLE [dbo].[stg_express_data];
GO

-- Load fresh data
INSERT INTO [dbo].[stg_express_data]
(
    transaction_date,
    payment_method,
    cashier_name,
    transaction_amount,
    transaction_discount,
    customer_first_name,
    customer_last_name,
    customer_email,
    customer_phone,
    customer_city,
    customer_province,
    customer_loyalty_tier,
    customer_since,
    store_name,
    store_city,
    store_province,
    store_region,
    store_manager,
    product_name,
    category,
    sub_category,
    sku,
    unit_price,
    cost_price,
    supplier,
    qty,
    line_amount,
    stock_on_hand,
    reorder_threshold
)
SELECT
    transaction_date,
    payment_method,
    cashier_name,
    transaction_amount,
    transaction_discount,
    customer_first_name,
    customer_last_name,
    customer_email,
    customer_phone,
    customer_city,
    customer_province,
    customer_loyalty_tier,
    customer_since,
    store_name,
    store_city,
    store_province,
    store_region,
    store_manager,
    product_name,
    category,
    sub_category,
    sku,
    unit_price,
    cost_price,
    supplier,
    qty,
    line_amount,
    stock_on_hand,
    reorder_threshold
FROM [dbo].[Express_Raw_Data];

PRINT 'Data loaded successfully into stg_express_data.';