-- =========================================
-- 01_create_tables.sql
-- Schema for core e-commerce operations DB
-- =========================================

PRAGMA foreign_keys = ON;

-- =====================
-- Customers
-- =====================
CREATE TABLE IF NOT EXISTS customers (
    customer_id     INTEGER PRIMARY KEY,
    first_name      TEXT NOT NULL,
    last_name       TEXT NOT NULL,
    -- Pre-aggregated metrics from source system
    total_orders    INTEGER,
    total_spent     REAL
);

-- =====================
-- Orders
-- =====================
CREATE TABLE IF NOT EXISTS orders (
    order_id    INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date  TEXT NOT NULL,         -- stored as ISO date string (YYYY-MM-DD)
    status      TEXT NOT NULL,         -- e.g. 'delivered', 'cancelled', 'shipped'
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- =====================
-- Products
-- =====================
CREATE TABLE IF NOT EXISTS products (
    product_id      INTEGER PRIMARY KEY,
    product_name    TEXT NOT NULL,
    category        TEXT NOT NULL,
    unit_price      REAL NOT NULL
);

-- =====================
-- Order Items
-- =====================
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id   INTEGER PRIMARY KEY,
    order_id        INTEGER NOT NULL,
    product_id      INTEGER NOT NULL,
    quantity        INTEGER NOT NULL,
    unit_price      REAL NOT NULL,
    discount        REAL NOT NULL DEFAULT 0.0,  -- monetary discount applied to this line
    FOREIGN KEY (order_id)  REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =====================
-- Inventory
-- =====================
CREATE TABLE IF NOT EXISTS inventory (
    inventory_id    INTEGER PRIMARY KEY,
    product_id      INTEGER NOT NULL,
    warehouse       TEXT NOT NULL,
    on_hand         INTEGER NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =====================
-- Returns
-- =====================
CREATE TABLE IF NOT EXISTS returns (
    return_id       INTEGER PRIMARY KEY,
    order_id        INTEGER NOT NULL,
    product_id      INTEGER NOT NULL,
    return_date     TEXT NOT NULL,
    reason          TEXT NOT NULL,
    refund_amount   REAL NOT NULL,
    FOREIGN KEY (order_id)  REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =====================
-- Shipments
-- =====================
CREATE TABLE IF NOT EXISTS shipments (
    shipment_id     INTEGER PRIMARY KEY,
    order_id        INTEGER NOT NULL,
    shipped_date    TEXT NOT NULL,
    delivered_date  TEXT,              -- may be NULL if not yet delivered
    carrier         TEXT NOT NULL,     -- e.g. 'UPS', 'USPS', 'FedEx', 'DHL'
    warehouse       TEXT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- =====================
-- (Optional) Sales Fact Table
-- =====================
-- This table can be populated via ETL / Python from the base tables.
-- Grain: one row per order line with net revenue.
CREATE TABLE IF NOT EXISTS sales_fact (
    sales_fact_id   INTEGER PRIMARY KEY,
    order_id        INTEGER NOT NULL,
    customer_id     INTEGER NOT NULL,
    product_id      INTEGER NOT NULL,
    order_date      TEXT NOT NULL,
    quantity        INTEGER NOT NULL,
    unit_price      REAL NOT NULL,
    discount        REAL NOT NULL DEFAULT 0.0,
    net_revenue     REAL NOT NULL,     -- quantity * unit_price - discount
    FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)