-- =========================================
-- 03_analysis.sql
-- Analysis queries for 10 business questions
-- =========================================

-------------------------------------------------
-- Q1. Top 10 customers by total revenue
-------------------------------------------------
SELECT
    customer_id,
    first_name,
    last_name,
    total_orders,
    total_spent AS total_revenue
FROM customers
ORDER BY total_revenue DESC
LIMIT 10;

-------------------------------------------------
-- Q2. Average Order Value (AOV) from delivered orders only
--    AOV = total revenue / number of delivered orders
-------------------------------------------------
WITH order_totals AS (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price - oi.discount) AS order_revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'delivered'
    GROUP BY o.order_id
)
SELECT
    SUM(order_revenue) AS total_revenue,
    COUNT(*) AS num_orders,
    ROUND(SUM(order_revenue) * 1.0 / COUNT(*), 2) AS average_order_value
FROM order_totals;

-------------------------------------------------
-- Q3. Products that have generated more than $1,000 in total net revenue
--     (delivered orders only)
-------------------------------------------------
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(oi.quantity * oi.unit_price - oi.discount) AS product_net_revenue,
    SUM(oi.quantity) AS total_units_sold
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status = 'delivered'
GROUP BY p.product_id, p.product_name, p.category
HAVING product_net_revenue > 1000
ORDER BY product_net_revenue DESC;

-------------------------------------------------
-- Q4. Customers with ≥ 3 orders in the last 90 days
--     (based on order_date relative to current date)
-------------------------------------------------
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS orders_last_90_days
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_date >= DATE('now', '-90 days')
  AND o.status = 'delivered'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) >= 3
ORDER BY orders_last_90_days DESC, c.customer_id
LIMIT 10;

-------------------------------------------------
-- Q5. For each product category, total units sold and total revenue
--     (delivered orders only)
-------------------------------------------------
SELECT
    p.category,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.unit_price - oi.discount) AS total_revenue
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status = 'delivered'
GROUP BY p.category
ORDER BY total_revenue DESC;

-------------------------------------------------
-- Q6. Which warehouse has the fastest average delivery time?
--     measured as avg(delivered_date - shipped_date)
-------------------------------------------------
SELECT
    warehouse,
    COUNT(*) AS num_shipments,
    ROUND(AVG(julianday(delivered_date) - julianday(shipped_date)), 2) AS avg_delivery_days
FROM shipments
WHERE delivered_date IS NOT NULL
GROUP BY warehouse
ORDER BY avg_delivery_days ASC;

-------------------------------------------------
-- Q7. Identify all orders that had discounts applied AND were later returned
-------------------------------------------------
SELECT
    r.return_id,
    r.order_id,
    r.product_id,
    r.return_date,
    r.reason,
    r.refund_amount,
    oi.quantity,
    oi.unit_price,
    oi.discount
FROM returns AS r
JOIN order_items AS oi
    ON r.order_id = oi.order_id
   AND r.product_id = oi.product_id
WHERE oi.discount > 0
ORDER BY r.return_date DESC;

-------------------------------------------------
-- Q8. For each customer, calculate their most recent order date
-------------------------------------------------
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    MAX(o.order_date) AS most_recent_order_date
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY most_recent_order_date DESC;

-------------------------------------------------
-- Q9. What percentage of orders were cancelled in the last 60 days?
-------------------------------------------------
WITH recent_orders AS (
    SELECT *
    FROM orders
    WHERE order_date >= DATE('now', '-60 days')
)
SELECT
    COUNT(*) AS total_recent_orders,
    SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(
        SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS cancelled_percentage
FROM recent_orders;

-------------------------------------------------
-- Q10. Top 3 carriers by on-time delivery rate
--      (delivered within 3 days of ship date)
-------------------------------------------------
WITH carrier_stats AS (
    SELECT
        carrier,
        COUNT(*) AS total_shipments,
        SUM(
            CASE
                WHEN delivered_date IS NOT NULL
                 AND (julianday(delivered_date) - julianday(shipped_date)) <= 3
                THEN 1 ELSE 0
            END
        ) AS on_time_shipments
    FROM shipments
    WHERE delivered_date IS NOT NULL
    GROUP BY carrier
)
SELECT
    carrier,
    total_shipments,
    on_time_shipments,
    ROUND(on_time_shipments * 100.0 / total_shipments, 2) AS on_time_rate_pct
FROM carrier_stats
ORDER BY on_time_rate_pct DESC
LIMIT 3;