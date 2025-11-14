# 🛠️ Methodology  
### How The Project Was Completed (Step-By-Step)

This section explains the full workflow used to clean, structure, and analyze the datasets.

---

## 1. Data Exploration
Each raw CSV was loaded into a Jupyter notebook and inspected using:

- `.head()` – sample rows  
- `.info()` – data types  
- `.describe()` – numerical summaries  
- `.isna().sum()` – missing values  
- `.nunique()` – uniqueness and potential keys  

This revealed issues such as:
- inconsistent casing  
- leading/trailing whitespace  
- dates stored as strings  
- invalid numeric formats  
- duplicate customer names with different IDs  
- separate line-item tables requiring aggregation  

---

## 2. Data Cleaning (Pandas)
For each dataset (customers, orders, order_items, products, inventory, returns, shipments), the following steps were applied:

### ✔ Remove leading/trailing whitespace  
```python
df[str_cols] = df[str_cols].apply(lambda col: col.str.strip())