USE PC_Data_DB;
GO

-- ============================================
-- Q1: Total revenue and margin by PC_Make
-- ============================================
SELECT
    PC_Make,
    COUNT(*) AS units_sold,
    SUM(Sale_Price) AS total_revenue,
    SUM(Sale_Price - Cost_Price) AS total_margin,
    AVG(Sale_Price - Cost_Price) AS avg_margin_per_unit
FROM [dbo].[vw_PCSalesFlat]
GROUP BY PC_Make
ORDER BY total_revenue DESC;
GO

-- ============================================
-- Q2: Sales by Continent
-- ============================================
SELECT
    Continent,
    COUNT(*) AS total_sales,
    SUM(Sale_Price) AS total_revenue,
    AVG(Sale_Price) AS avg_sale_price
FROM [dbo].[vw_PCSalesFlat]
GROUP BY Continent
ORDER BY total_revenue DESC;
GO

-- ============================================
-- Q3: Channel comparison — Online vs Offline
-- ============================================
SELECT
    Channel,
    COUNT(*) AS total_sales,
    SUM(Sale_Price) AS total_revenue,
    AVG(Discount_Amount) AS avg_discount,
    SUM(CASE WHEN Finance_Amount > 0 THEN 1 ELSE 0 END) AS financed_sales_count
FROM [dbo].[vw_PCSalesFlat]
GROUP BY Channel
ORDER BY total_revenue DESC;
GO

-- ============================================
-- Q4: Sales person performance by department
-- ============================================
SELECT
    Sales_Person_Department,
    Sales_Person_Name,
    COUNT(*) AS total_sales,
    SUM(Sale_Price) AS total_revenue,
    AVG(Total_Sales_per_Employee) AS avg_reported_total_sales
FROM [dbo].[vw_PCSalesFlat]
GROUP BY Sales_Person_Department, Sales_Person_Name
ORDER BY total_revenue DESC;
GO

-- ============================================
-- Q5: Priority level vs average cost of repairs
--     (does higher priority correlate with more repair costs?)
-- ============================================
SELECT
    Priority,
    COUNT(*) AS total_sales,
    AVG(Cost_of_Repairs) AS avg_repair_cost,
    SUM(CASE WHEN Cost_of_Repairs > 0 THEN 1 ELSE 0 END) AS sales_with_repairs
FROM [dbo].[vw_PCSalesFlat]
GROUP BY Priority
ORDER BY avg_repair_cost DESC;
GO

-- ============================================
-- Q6: Credit score bands vs use of Finance as payment method
-- ============================================
SELECT
    CASE
        WHEN Credit_Score < 580 THEN 'Poor (<580)'
        WHEN Credit_Score BETWEEN 580 AND 669 THEN 'Fair (580-669)'
        WHEN Credit_Score BETWEEN 670 AND 739 THEN 'Good (670-739)'
        WHEN Credit_Score BETWEEN 740 AND 799 THEN 'Very Good (740-799)'
        WHEN Credit_Score >= 800 THEN 'Exceptional (800+)'
        ELSE 'Unknown'
    END AS credit_band,
    COUNT(*) AS total_sales,
    SUM(CASE WHEN Payment_Method = 'Finance' THEN 1 ELSE 0 END) AS finance_sales,
    CAST(SUM(CASE WHEN Payment_Method = 'Finance' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS finance_rate
FROM [dbo].[vw_PCSalesFlat]
GROUP BY
    CASE
        WHEN Credit_Score < 580 THEN 'Poor (<580)'
        WHEN Credit_Score BETWEEN 580 AND 669 THEN 'Fair (580-669)'
        WHEN Credit_Score BETWEEN 670 AND 739 THEN 'Good (670-739)'
        WHEN Credit_Score BETWEEN 740 AND 799 THEN 'Very Good (740-799)'
        WHEN Credit_Score >= 800 THEN 'Exceptional (800+)'
        ELSE 'Unknown'
    END
ORDER BY finance_rate DESC;
GO

-- ============================================
-- Q7: Monthly sales trend (using Purchase_Date, since it's always populated)
-- ============================================
SELECT
    YEAR(Purchase_Date) AS sale_year,
    MONTH(Purchase_Date) AS sale_month,
    COUNT(*) AS total_sales,
    SUM(Sale_Price) AS total_revenue
FROM [dbo].[vw_PCSalesFlat]
GROUP BY YEAR(Purchase_Date), MONTH(Purchase_Date)
ORDER BY sale_year, sale_month;
GO