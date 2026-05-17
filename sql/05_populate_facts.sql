-- ════════════════════════════════════════════════════════════════
-- 05_populate_facts.sql
-- Populate fact_sales by joining raw data to dimension keys
-- Run AFTER all dimension tables are populated
-- ════════════════════════════════════════════════════════════════

INSERT INTO warehouse.fact_sales (
    shop_key,
    product_key,
    customer_key,
    salesperson_key,
    date_key,
    ship_date_key,
    junk_key,
    cost_price,
    sale_price,
    discount_amount,
    finance_amount,
    cost_of_repairs,
    total_sales_per_employee
)
SELECT
    ds.shop_key,
    dp.product_key,
    dc.customer_key,
    dsp.salesperson_key,

    -- Purchase date key
    TO_DATE(r.purchase_date, 'MM/DD/YYYY')              AS date_key,

    -- Ship date key — NULL if N/A or missing
    CASE
        WHEN r.ship_date IN ('N/A', '', 'null') THEN NULL
        WHEN r.ship_date IS NULL                THEN NULL
        ELSE TO_DATE(r.ship_date, 'MM/DD/YYYY')
    END                                                  AS ship_date_key,

    dj.junk_key,

    -- Measures — cast from TEXT to DECIMAL
    NULLIF(TRIM(r.cost_price),               '')::DECIMAL(10,2),
    NULLIF(TRIM(r.sale_price),               '')::DECIMAL(10,2),
    COALESCE(NULLIF(TRIM(r.discount_amount), '')::DECIMAL(10,2), 0),
    COALESCE(NULLIF(TRIM(r.finance_amount),  '')::DECIMAL(10,2), 0),
    COALESCE(NULLIF(TRIM(r.cost_of_repairs), '')::DECIMAL(10,2), 0),
    NULLIF(TRIM(r.total_sales_per_employee), '')::DECIMAL(10,2)

FROM raw.pc_sales r

-- JOIN each raw row to its dimension key
JOIN warehouse.dim_shop        ds  ON INITCAP(TRIM(r.shop_name))           = ds.shop_name
JOIN warehouse.dim_product     dp  ON INITCAP(TRIM(r.pc_make))             = dp.pc_make
                                   AND INITCAP(TRIM(r.pc_model))            = dp.pc_model
JOIN warehouse.dim_customer    dc  ON INITCAP(TRIM(r.customer_name))       = dc.first_name
                                   AND INITCAP(TRIM(r.customer_surname))    = dc.last_name
JOIN warehouse.dim_salesperson dsp ON INITCAP(TRIM(r.sales_person_name))   = dsp.salesperson_name
JOIN warehouse.dim_junk        dj  ON INITCAP(TRIM(r.payment_method))      = dj.payment_method
                                   AND INITCAP(TRIM(r.channel))             = dj.channel
                                   AND INITCAP(TRIM(r.priority))            = dj.priority

-- Only load rows with valid purchase dates
WHERE r.purchase_date IS NOT NULL
  AND r.purchase_date NOT IN ('N/A', '', 'null');


-- ── Data quality checks ───────────────────────────────────────
SELECT 'NULL shop_key'        AS check_name, COUNT(*) AS failures FROM warehouse.fact_sales WHERE shop_key        IS NULL
UNION ALL
SELECT 'NULL product_key',                   COUNT(*)              FROM warehouse.fact_sales WHERE product_key     IS NULL
UNION ALL
SELECT 'NULL customer_key',                  COUNT(*)              FROM warehouse.fact_sales WHERE customer_key    IS NULL
UNION ALL
SELECT 'NULL salesperson_key',               COUNT(*)              FROM warehouse.fact_sales WHERE salesperson_key IS NULL
UNION ALL
SELECT 'NULL date_key',                      COUNT(*)              FROM warehouse.fact_sales WHERE date_key        IS NULL
UNION ALL
SELECT 'NULL sale_price',                    COUNT(*)              FROM warehouse.fact_sales WHERE sale_price       IS NULL
UNION ALL
SELECT 'Negative net_profit',                COUNT(*)              FROM warehouse.fact_sales WHERE net_profit       < 0
UNION ALL
SELECT 'fact_sales total rows',              COUNT(*)              FROM warehouse.fact_sales;
