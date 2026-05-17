-- ════════════════════════════════════════════════════════════════
-- 02_dim_tables.sql
-- Create all 6 dimension tables in the warehouse schema
-- This is the GOLD layer — clean, typed, deduplicated
-- Run AFTER loading raw data
-- ════════════════════════════════════════════════════════════════


-- ── dim_shop ─────────────────────────────────────────────────
-- Describes WHERE the sale happened
-- One row per unique shop location
-- Geographic hierarchy: Continent → Country → Province/City

CREATE TABLE warehouse.dim_shop (
    shop_key        SERIAL          PRIMARY KEY,
    shop_name       VARCHAR(100)    NOT NULL,
    shop_age        INT,
    continent       VARCHAR(50),
    country         VARCHAR(100),
    province_city   VARCHAR(100),

    -- Audit columns
    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);



-- ── dim_product ───────────────────────────────────────────────
-- Describes WHAT was sold
-- One row per unique PC make + model combination

CREATE TABLE warehouse.dim_product (
    product_key      SERIAL          PRIMARY KEY,
    pc_make          VARCHAR(100)    NOT NULL,
    pc_model         VARCHAR(100)    NOT NULL,
    storage_type     VARCHAR(10),
    storage_capacity VARCHAR(20),
    ram              VARCHAR(20),
    pc_market_price  DECIMAL(10,2),

    created_at       TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);



-- ── dim_customer ──────────────────────────────────────────────
-- Describes WHO bought the PC
-- One row per unique customer
-- SCD Type 2 ready — effective/expiry dates for tracking changes

CREATE TABLE warehouse.dim_customer (
    customer_key      SERIAL          PRIMARY KEY,
    first_name        VARCHAR(100)    NOT NULL,
    last_name         VARCHAR(100)    NOT NULL,
    full_name         VARCHAR(200)    GENERATED ALWAYS AS (first_name || ' ' || last_name) STORED,
    contact_number    VARCHAR(30),
    email_address     VARCHAR(200),
    credit_score      INT,

    -- SCD Type 2 columns
    effective_date    DATE            DEFAULT CURRENT_DATE,
    expiry_date       DATE            DEFAULT '9999-12-31',
    is_current        BOOLEAN         DEFAULT TRUE,

    created_at        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);



-- ── dim_salesperson ───────────────────────────────────────────
-- Describes WHO made the sale
-- One row per unique salesperson
-- SCD Type 2 ready — tracks department changes over time

CREATE TABLE warehouse.dim_salesperson (
    salesperson_key   SERIAL          PRIMARY KEY,
    salesperson_name  VARCHAR(100)    NOT NULL,
    department        VARCHAR(100),

    -- SCD Type 2 columns
    effective_date    DATE            DEFAULT CURRENT_DATE,
    expiry_date       DATE            DEFAULT '9999-12-31',
    is_current        BOOLEAN         DEFAULT TRUE,

    created_at        TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);



-- ── dim_date ──────────────────────────────────────────────────
-- One row per calendar date
-- Used TWICE in fact_sales:
--   date_key      → purchase date
--   ship_date_key → ship date
-- This is called a ROLE-PLAYING DIMENSION

CREATE TABLE warehouse.dim_date (
    date_key        DATE            PRIMARY KEY,
    day             INT             NOT NULL,
    month           INT             NOT NULL,
    month_name      VARCHAR(20)     NOT NULL,
    quarter         INT             NOT NULL,
    year            INT             NOT NULL,
    day_of_week     INT,
    day_name        VARCHAR(20),
    is_weekend      BOOLEAN         DEFAULT FALSE,

    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);



-- ── dim_junk ──────────────────────────────────────────────────
-- Groups low-cardinality flags together
-- Describes HOW the sale happened
-- Payment Method + Channel + Priority
-- Each has very few possible values — too small for own dim table

CREATE TABLE warehouse.dim_junk (
    junk_key        SERIAL          PRIMARY KEY,
    payment_method  VARCHAR(50),
    channel         VARCHAR(20),
    priority        VARCHAR(20),

    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP
);



-- ── Verify all dimension tables created ───────────────────────
SELECT
    table_name,
    COUNT(column_name) AS column_count
FROM information_schema.columns
WHERE table_schema = 'warehouse'
GROUP BY table_name
ORDER BY table_name;
