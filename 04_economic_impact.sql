-- 04_economic_impact.sql
-- Purpose: Analyze order value and freight impact by state; percentage changes year-over-year

-- % increase in cost of orders from 2017 to 2018 (Jan-Aug)
WITH cte AS (
  SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    SUM(p.payment_value) AS cost_of_orders
  FROM `scaler-project-465604.Target.orders` AS o
  LEFT JOIN `scaler-project-465604.Target.payments` AS p
    ON o.order_id = p.order_id
  WHERE 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) IN (2017, 2018)
    AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 8
  GROUP BY year
)
SELECT
  ROUND(((cost_2018 - cost_2017) / cost_2017) * 100, 2) AS percent_increase
FROM (
  SELECT
    MAX(CASE WHEN year = 2017 THEN cost_of_orders END) AS cost_2017,
    MAX(CASE WHEN year = 2018 THEN cost_of_orders END) AS cost_2018
  FROM cte
);

-- Total & average order value per state
SELECT
  c.customer_state AS state,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(p.payment_value),2) AS total_order_value,
  ROUND(AVG(p.payment_value),2) AS avg_order_value
FROM `scaler-project-465604.Target.orders` o
JOIN `scaler-project-465604.Target.customers` c
  ON o.customer_id = c.customer_id
JOIN `scaler-project-465604.Target.payments` p
  ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY total_order_value DESC;

-- Freight value per state
SELECT
  c.customer_state AS state,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(SUM(oi.freight_value),2) AS total_freight,
  ROUND(AVG(oi.freight_value),2) AS avg_freight
FROM `scaler-project-465604.Target.orders` o
JOIN `scaler-project-465604.Target.customers` c
  ON o.customer_id = c.customer_id
JOIN `scaler-project-465604.Target.orders_items` oi
  ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY total_freight DESC;