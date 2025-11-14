-- =========================================
-- 02_queries.sql
-- Reusable core queries / building blocks
-- =========================================

-- 1) List all tables in the database
SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;

-- 2) Row counts for each core table
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'inventory', COUNT(*) FROM inventory
UNION ALL
SELECT 'returns', COUNT(*) FROM returns
UNION ALL
SELECT 'shipments', COUNT(*) FROM shipments;

-- 3) Preview customers
SELECT *
FROM customers
LIMIT 10;

-- 4) Orders by status
SELECT
    status,
    COUNT(*) AS num_orders
FROM orders
GROUP BY status
ORDER BY num_orders DESC;

-- 5) Revenue by product category (delivered orders only)
SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price - oi.discount) AS category_revenue,
    SUM(oi.quantity) AS units_sold
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
WHERE o.status = 'delivered'
GROUP BY p.category
ORDER BY category_revenue DESC;

-- 6) Top 10 customers by total_spent (pre-aggregated field)
SELECT
    customer_id,
    first_name,
    last_name,
    total_orders,
    total_spent
FROM customers
ORDER BY total_spent DESC
LIMIT 10;

-- 7) Shipments by carrier with average delivery time
SELECT
    carrier,
    COUNT(*) AS num_shipments,
    AVG(julianday(delivered_date) - julianday(shipped_date)) AS avg_delivery_days
FROM shipments
WHERE delivered_date IS NOT NULL
GROUP BY carrier
ORDER BY avg_delivery_days ASC;

-- 8) Returns by reason
SELECT
    reason,
    COUNT(*) AS num_returns,
    SUM(refund_amount) AS total_refund_amount
FROM returns
GROUP BY reason
ORDER BY num_returns DESC;