-- ════════════════════════════════════════════════════════════════
-- 01_raw_schema.sql
-- Create the RAW schema and staging table
-- This is the BRONZE layer — data lands here exactly as it arrives
-- Nothing is changed, cleaned, or transformed at this stage
-- ════════════════════════════════════════════════════════════════

DROP SCHEMA IF EXISTS raw       CASCADE;
DROP SCHEMA IF EXISTS staging   CASCADE;
DROP SCHEMA IF EXISTS warehouse CASCADE;

CREATE SCHEMA raw;
CREATE SCHEMA staging;
CREATE SCHEMA warehouse;

-- Raw table — every column stored as TEXT
-- Why TEXT? Because raw data is messy:
-- dates have different formats, numbers may have symbols,
-- NULL values may come in as 'N/A' or empty strings
-- We cast to proper types in the staging layer

CREATE TABLE raw.pc_sales (
    continent                TEXT,
    country_or_state         TEXT,
    province_or_city         TEXT,
    shop_name                TEXT,
    shop_age                 TEXT,
    pc_make                  TEXT,
    pc_model                 TEXT,
    storage_type             TEXT,
    customer_name            TEXT,
    customer_surname         TEXT,
    customer_contact_number  TEXT,
    customer_email_address   TEXT,
    sales_person_name        TEXT,
    sales_person_department  TEXT,
    cost_price               TEXT,
    sale_price               TEXT,
    payment_method           TEXT,
    discount_amount          TEXT,
    purchase_date            TEXT,
    ship_date                TEXT,
    finance_amount           TEXT,
    ram                      TEXT,
    credit_score             TEXT,
    channel                  TEXT,
    priority                 TEXT,
    cost_of_repairs          TEXT,
    total_sales_per_employee TEXT,
    pc_market_price          TEXT,
    storage_capacity         TEXT,
    loaded_at                TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Verify
SELECT 'raw.pc_sales created successfully' AS status;
