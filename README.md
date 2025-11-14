# 🛒 E-Commerce Operations Analytics  
**SQL • Data Cleaning • Business Insights • Portfolio Project**

This project analyzes a fictional e-commerce company’s operations data across customers, orders, products, order items, returns, inventory, and shipments.  
It demonstrates a full analytics workflow — **from raw data → cleaned datasets → SQL insights → business recommendations**.

---

## 📌 Project Goals

This analysis simulates the real work performed by Data Analysts in:
- E-commerce
- Operations / Logistics
- Customer analytics
- Sportsbook & fantasy sports operations teams (PrizePicks, Underdog, FanDuel)

**Objectives:**
1. Clean, validate, and structure multiple raw CSV files.  
2. Build a relational SQLite database (`ecommerce_ops.db`).  
3. Write SQL queries to answer real business questions.  
4. Understand customer behavior, product performance, revenue drivers, returns, and shipping efficiency.  
5. Present insights clearly with markdown summaries and recommendations.

---

## 🧰 Tools & Skills Demonstrated

- **SQL (SQLite)** → joins, aggregations, filtering, date functions, HAVING clauses  
- **Python / Pandas** → data cleaning & preprocessing  
- **Jupyter Notebook** → analysis structure & storytelling  
- **Markdown** → insights, commentary, business recommendations  
- **Data Modeling** → creating a small star-schema structure  
- **KPI Development** → operational metrics used in real analyst roles  

---

## 📂 Project Structure

─ 01_ecommerce_ops_analytics/
├── data/
│ ├── raw/ ← raw CSV files
│ └── processed/ ← cleaned datasets + ecommerce_ops.db
├── 02_docs/
│ ├── 01_project_overview.md
│ ├── 02_methodology.md
│ ├── 03_kpis.md
│ └── 04_findings.md
├── 03_notebooks/
│ ├── 01_data_exploration.ipynb
│ ├── 02_data_cleaning.ipynb
│ └── 03_sales_analysis.ipynb
├── 04_sql/
│ ├── 01_create_tables.sql
│ ├── 02_queries.sql
│ └── 03_analysis.sql
└── README.md


## 🧼 Data Cleaning Summary

All datasets were cleaned using Python/Pandas:  
- Standardized column names  
- Fixed inconsistent casing  
- Trimmed whitespace  
- Converted data types  
- Repaired numeric formats  
- Handled missing values  
- Validated `customer_id`, `order_id`, `product_id` relationships  
- Built the final relational database: **`ecommerce_ops.db`**

Detailed steps are inside **02_data_cleaning.ipynb**.

---

## 📊 Key Business Questions Answered

The analysis answers 10 real-world operations questions, including:

1. Top customers by total revenue  
2. Average Order Value (AOV)  
3. Products generating > $1,000 in revenue  
4. Repeat-purchase customers (≥ 3 orders in last 90 days)  
5. Fastest warehouse by delivery time  
6. Carrier performance (on-time delivery rate)  
7. Category-level revenue & units sold  
8. Total returned discounted orders  
9. Last 60-day cancellation rate  
10. Customer recency (most recent order dates)

Each question includes:
- SQL query  
- Result table  
- Business interpretation  

All are inside **03_sales_analysis.ipynb**.

---

## 📈 Example Insights (from findings)

- **DFW-02 is the fastest warehouse** with ~2.9-day delivery time.  
- **Electronics drive most of the company’s revenue**, followed by Sports.  
- **AOV = $332.33**, suggesting high average spend per order.  
- **Beauty sold the most units (76)** but was low in total revenue → low price point inventory.  
- **Only one discounted product was returned**, showing strong discounting performance.  
- **Cancellation rate is 9.1%**, within normal operational range.

---

## 🚀 Next Steps

- Build customer segmentation using **RFM Analysis**  
- Add dashboards (Power BI or Tableau)  
- Expand SQL with advanced window functions  
- Create predictive models (order frequency, return probability)  
- Begin second analytics project for deeper portfolio depth  

---

## 📞 Contact

If you'd like to discuss the project or collaborate:

**Jaylund Harris**  
Aspiring Data Analyst | SQL • Python • Operations Analytics  
GitHub: (https://github.com/Jaylundharris)
LinkedIn: https://www.linkedin.com/in/jaylund-harris-571936384/

---

## ⭐ Why This Project Matters

This project was built to demonstrate the **four essential analyst skills**:

1. **Data Cleaning**  
2. **SQL Querying**  
3. **Analytical Thinking**  
4. **Business Communication**