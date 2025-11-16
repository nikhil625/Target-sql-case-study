-- 05_delivery_analysis.sql
-- Purpose: Delivery performance analysis: actual vs estimated, delivery days, top/bottom states

-- Delivery time and difference between estimated & actual
SELECT
  o.order_id,
  DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY) AS time_to_deliver,
  DATE_DIFF(o.order_estimated_delivery_date, o.order_delivered_customer_date, DAY) AS diff_estimated_delivery
FROM `scaler-project-465604.Target.orders` o
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_purchase_timestamp IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL;

-- Top 5 states with highest & lowest average freight (reused pattern for delivery time)
WITH avg_delivery AS (
  SELECT
    c.customer_state AS state,
    AVG(TIMESTAMP_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)) AS avg_delivery_time
  FROM `scaler-project-465604.Target.orders` o
  JOIN `scaler-project-465604.Target.customers` c
    ON o.customer_id = c.customer_id
  WHERE o.order_delivered_customer_date IS NOT NULL
  GROUP BY state
)
SELECT * FROM (
  SELECT * FROM avg_delivery ORDER BY avg_delivery_time ASC LIMIT 5
  UNION ALL
  SELECT * FROM avg_delivery ORDER BY avg_delivery_time DESC LIMIT 5
)
ORDER BY avg_delivery_time ASC;