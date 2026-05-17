-- ════════════════════════════════════════════════════════════════
-- 04_populate_dims.sql
-- Populate all dimension tables from raw.pc_sales
-- Applies cleaning, casting, and deduplication
-- Run AFTER raw data is loaded into raw.pc_sales
-- ════════════════════════════════════════════════════════════════


-- ── 1. Populate dim_date ──────────────────────────────────────
-- Generate one row per unique date from both purchase and ship dates
-- Handles N/A ship dates by filtering them out

INSERT INTO warehouse.dim_date (
    date_key, day, month, month_name,
    quarter, year, day_of_week, day_name, is_weekend
)
SELECT DISTINCT
    d::DATE                                    AS date_key,
    EXTRACT(DAY    FROM d)::INT                AS day,
    EXTRACT(MONTH  FROM d)::INT                AS month,
    TO_CHAR(d, 'Month')                        AS month_name,
    EXTRACT(QUARTER FROM d)::INT               AS quarter,
    EXTRACT(YEAR   FROM d)::INT                AS year,
    EXTRACT(DOW    FROM d)::INT                AS day_of_week,
    TO_CHAR(d, 'Day')                          AS day_name,
    EXTRACT(DOW    FROM d) IN (0, 6)           AS is_weekend
FROM (
    -- Purchase dates
    SELECT TO_DATE(purchase_date, 'MM/DD/YYYY') AS d
    FROM raw.pc_sales
    WHERE purchase_date IS NOT NULL
      AND purchase_date NOT IN ('N/A', '', 'null')

    UNION

    -- Ship dates (skip N/A values)
    SELECT TO_DATE(ship_date, 'MM/DD/YYYY') AS d
    FROM raw.pc_sales
    WHERE ship_date IS NOT NULL
      AND ship_date NOT IN ('N/A', '', 'null')
) dates
ON CONFLICT (date_key) DO NOTHING;


-- ── 2. Populate dim_shop ──────────────────────────────────────
-- One row per unique shop
-- Deduplicate on shop_name + continent + country + city

INSERT INTO warehouse.dim_shop (
    shop_name, shop_age, continent,
    country, province_city
)
SELECT DISTINCT
    INITCAP(TRIM(shop_name))            AS shop_name,
    NULLIF(TRIM(shop_age), '')::INT     AS shop_age,
    INITCAP(TRIM(continent))            AS continent,
    INITCAP(TRIM(country_or_state))     AS country,
    INITCAP(TRIM(province_or_city))     AS province_city
FROM raw.pc_sales
WHERE shop_name IS NOT NULL
  AND TRIM(shop_name) != '';


-- ── 3. Populate dim_product ───────────────────────────────────
-- One row per unique PC make + model combination

INSERT INTO warehouse.dim_product (
    pc_make, pc_model, storage_type,
    storage_capacity, ram, pc_market_price
)
SELECT DISTINCT
    INITCAP(TRIM(pc_make))                              AS pc_make,
    INITCAP(TRIM(pc_model))                             AS pc_model,
    UPPER(TRIM(storage_type))                           AS storage_type,
    UPPER(TRIM(storage_capacity))                       AS storage_capacity,
    UPPER(TRIM(ram))                                    AS ram,
    NULLIF(TRIM(pc_market_price), '')::DECIMAL(10,2)    AS pc_market_price
FROM raw.pc_sales
WHERE pc_make  IS NOT NULL AND TRIM(pc_make)  != ''
  AND pc_model IS NOT NULL AND TRIM(pc_model) != '';


-- ── 4. Populate dim_customer ──────────────────────────────────
-- One row per unique customer (deduplicated on name + email)
-- Email lowercased for consistency

INSERT INTO warehouse.dim_customer (
    first_name, last_name,
    contact_number, email_address, credit_score
)
SELECT DISTINCT
    INITCAP(TRIM(customer_name))                        AS first_name,
    INITCAP(TRIM(customer_surname))                     AS last_name,
    TRIM(customer_contact_number)                       AS contact_number,
    LOWER(TRIM(customer_email_address))                 AS email_address,
    NULLIF(TRIM(credit_score), '')::INT                 AS credit_score
FROM raw.pc_sales
WHERE customer_name    IS NOT NULL AND TRIM(customer_name)    != ''
  AND customer_surname IS NOT NULL AND TRIM(customer_surname) != '';


-- ── 5. Populate dim_salesperson ───────────────────────────────
-- One row per unique salesperson + department combination

INSERT INTO warehouse.dim_salesperson (
    salesperson_name, department
)
SELECT DISTINCT
    INITCAP(TRIM(sales_person_name))            AS salesperson_name,
    INITCAP(TRIM(sales_person_department))      AS department
FROM raw.pc_sales
WHERE sales_person_name IS NOT NULL
  AND TRIM(sales_person_name) != '';


-- ── 6. Populate dim_junk ──────────────────────────────────────
-- One row per unique combination of payment_method + channel + priority

INSERT INTO warehouse.dim_junk (
    payment_method, channel, priority
)
SELECT DISTINCT
    INITCAP(TRIM(payment_method))   AS payment_method,
    INITCAP(TRIM(channel))          AS channel,
    INITCAP(TRIM(priority))         AS priority
FROM raw.pc_sales
WHERE payment_method IS NOT NULL
  AND TRIM(payment_method) != '';


-- ── Verify all dimension row counts ───────────────────────────
SELECT 'dim_date'        AS dim_table, COUNT(*) AS rows FROM warehouse.dim_date
UNION ALL
SELECT 'dim_shop',                     COUNT(*)         FROM warehouse.dim_shop
UNION ALL
SELECT 'dim_product',                  COUNT(*)         FROM warehouse.dim_product
UNION ALL
SELECT 'dim_customer',                 COUNT(*)         FROM warehouse.dim_customer
UNION ALL
SELECT 'dim_salesperson',              COUNT(*)         FROM warehouse.dim_salesperson
UNION ALL
SELECT 'dim_junk',                     COUNT(*)         FROM warehouse.dim_junk
ORDER BY dim_table;
