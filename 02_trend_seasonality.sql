-- 02_trend_seasonality.sql
-- Purpose: Analyze yearly/monthly trends and seasonality, time of day patterns

-- Monthly orders trend
SELECT
  EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
  EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
  COUNT(order_id) AS monthly_orders
FROM `scaler-project-465604.Target.orders`
GROUP BY year, month
ORDER BY year, month;

-- Monthly seasonality (avg across years)
WITH monthly AS (
  SELECT
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
    COUNT(order_id) AS monthly_orders
  FROM `scaler-project-465604.Target.orders`
  GROUP BY year, month
)
SELECT
  month,
  ROUND(AVG(monthly_orders),2) AS avg_orders
FROM monthly
GROUP BY month
ORDER BY month;

-- Time of day distribution (Brazil)
SELECT
  CASE
    WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 0 AND 6 THEN 'Dawn'
    WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 7 AND 12 THEN 'Morning'
    WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 13 AND 18 THEN 'Afternoon'
    ELSE 'Night'
  END AS time_of_day,
  COUNT(*) AS total_orders
FROM `scaler-project-465604.Target.orders`
GROUP BY time_of_day
ORDER BY total_orders DESC;