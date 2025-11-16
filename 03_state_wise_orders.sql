-- 03_state_wise_orders.sql
-- Purpose: Month-on-month orders per state and customer distribution

-- Month-on-month orders per state
SELECT
  c.customer_state,
  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
  EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
  COUNT(o.order_id) AS total_orders
FROM `scaler-project-465604.Target.orders` o
LEFT JOIN `scaler-project-465604.Target.customers` c
  ON o.customer_id = c.customer_id
GROUP BY c.customer_state, year, month
ORDER BY c.customer_state, year, month;

-- Customer distribution across states
SELECT
  customer_state AS state,
  COUNT(DISTINCT customer_unique_id) AS total_customers
FROM `scaler-project-465604.Target.customers`
GROUP BY customer_state
ORDER BY total_customers DESC;