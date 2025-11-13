# SQL Project: Retail Operations & Analytics (Warehouse-to-Analytics)

**Goal:** Demonstrate SQL skills end-to-end using a realistic retail dataset that maps to ops/logistics + analytics roles.

## 📦 What’s Included
- `retail_ops_analytics.sqlite` — SQLite database with **customers, products, orders, order_items, shipments, inventory, returns**.
- `queries.sql` — 15 core SQL prompts + a few worked examples.

## 🗂️ Schema (ERD - text)
- customers(customer_id, full_name, email, state, signup_date)
- products(product_id, product_name, category, unit_price)
- orders(order_id, customer_id, order_date, status)
- order_items(order_id, product_id, quantity, unit_price, discount)
- shipments(shipment_id, order_id, warehouse, carrier, shipped_date, delivered_date)
- inventory(product_id, on_hand, reorder_point, last_restock_date)
- returns(return_id, order_id, product_id, return_date, reason, refund_amount)

## 🔎 15 SQL Questions to Answer
1) Revenue by Month (last 6 months), excluding cancelled orders and accounting for discounts.
2) Top 10 Products by Revenue and their categories.
3) Customer Repeat Rate: % of customers with ≥2 orders in the last 90 days.
4) Average Order Value (AOV) by month.
5) Delivery SLA: % of delivered orders arriving within 5 days of ship date, by carrier and warehouse.
6) Return Rate by category. Which categories have the highest refund amounts?
7) Inventory Risk: products where on_hand < reorder_point with last_restock_date.
8) Cohort Analysis: customers grouped by signup month; month-1 repeat purchase rate.
9) State-Level Performance: Top 5 states by revenue in the last 120 days.
10) Cancellation Heatmap: Which weekdays see the most cancellations?
11) Category Momentum: 30-day rolling revenue by category (window function).
12) Order-to-Ship Lag: Average hours between order_date and shipped_date by warehouse.
13) High-Value Customers: customers with lifetime spend ≥ $1,000.
14) Basket Analysis: For Electronics, avg items per order and % orders with ≥2 electronics items.
15) Refund Leakage: compare total refunds vs delivered revenue over the last 60 days.

## 🧪 Stretch
- Build a simple chart (Power BI or Excel) for Q1, Q5, or Q9 and add a screenshot to your portfolio/LinkedIn.
- Create views for common metrics (e.g., v_order_revenue, v_delivered_orders).

## 📤 How to Use
Open the `.sqlite` file in DB Browser for SQLite or DBeaver. Run the examples in `queries.sql`, then add your answers below each prompt.

## ✅ Portfolio Tips
In your README: include business context, SQL snippets, and 2–3 key insights.
On LinkedIn: share 1 chart + 4 bullet insights. Keep it honest and clear.
