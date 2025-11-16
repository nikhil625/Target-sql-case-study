-- 06_payment_analysis.sql
-- Purpose: Payment behavior: payment types and installments

-- Month-on-month orders by payment type
SELECT
  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS order_year,
  EXTRACT(MONTH FROM o.order_purchase_timestamp) AS order_month,
  p.payment_type,
  COUNT(DISTINCT o.order_id) AS total_orders
FROM `scaler-project-465604.Target.orders` o
JOIN `scaler-project-465604.Target.payments` p
  ON o.order_id = p.order_id
GROUP BY order_year, order_month, p.payment_type
ORDER BY order_year, order_month, p.payment_type;

-- Orders by number of installments
SELECT
  payment_installments,
  COUNT(DISTINCT order_id) AS total_orders
FROM `scaler-project-465604.Target.payments`
GROUP BY payment_installments
ORDER BY payment_installments;