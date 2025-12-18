-- 01_exploratory_analysis.sql
-- Author: Nikhil Mehalawat
-- Purpose: Basic EDA - data types, date ranges, count of cities & states
-- {orders, customers, payments, orders_items}
-- Run in BigQuery

-- 1. Data types (customers table) - BigQuery: use INFORMATION_SCHEMA or inspect manually
-- Example:
SELECT
  column_name,
  data_type
FROM `scaler-project-465604.Target.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'customers';

-- 2. Time range of orders
SELECT
  MIN(order_purchase_timestamp) AS first_order,
  MAX(order_purchase_timestamp) AS last_order
FROM `scaler-project-465604.Target.orders`;

-- 3. Count cities & states of customers who ordered in the period
SELECT
  c.customer_state,
  c.customer_city,
  COUNT(DISTINCT o.order_id) AS orders_count
FROM `scaler-project-465604.Target.orders` o
JOIN `scaler-project-465604.Target.customers` c
  ON o.customer_id = c.customer_id
GROUP BY c.customer_state, c.customer_city
ORDER BY orders_count DESC
LIMIT 100;
