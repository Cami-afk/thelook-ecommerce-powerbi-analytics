# The Look E-commerce – BI Analysis (Power BI + BigQuery)

[![Power BI interactive report](https://img.shields.io/badge/PowerBI-Live%20Dashboard-yellow?logo=powerbi)](https://app.powerbi.com/view?r=eyJrIjoiMmRhMGYwMjktYzY1OS00MTFiLWJmMWYtOTc0ZjZkN2Y1OWRjIiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9)

**Power BI · DAX · BigQuery · SQL · Data Modeling**

## Business Context

This project uses multi-table e-commerce data (orders, order items, products, users, events, inventory and distribution centers) to identify revenue drivers, marketing channel effectiveness and geographic differences in performance.

The objective was to identify revenue concentration, channel efficiency and regional growth potential.

Dataset: https://www.kaggle.com/datasets/mustafakeser4/looker-ecommerce-bigquery-dataset

---

## Data Model

The Power BI model follows a **constellation schema** (multi-fact star model) combining sales and web analytics data.  
The central analytical fact table is `order_items`, supported by additional fact tables (`orders`, `events`, `inventory_items`) and shared dimensions.

**Primary Sales Fact**
- `order_items` (sales at item level)

**Supporting Fact Tables**
- `orders` (order-level attributes, timestamps, status)
- `events` (web traffic and user interactions)
- `inventory_items` (inventory and logistics layer)

**Dimension tables**
- `products` (category, brand, retail_price)
- `users` (geo, demographics, traffic_source)
- `distribution_centers` (logistics dimension)
- `calendar` (date dimension created via `CALENDARAUTO()`)
- `countries` (reference table for population and penetration analysis)

Time intelligence is driven by an active relationship between `calendar` and `orders (created_at)`, ensuring revenue analysis reflects order creation date rather than delivery date.

Relationships were configured using single-direction filtering (1 → *) to maintain a clean and predictable filter context.

---

## Dashboard Preview

### Data Model
![Data Model](screenshots/model_view.png)

### Dashboard Overview
![Dashboard Overview](screenshots/dashboard_overview.png)

---

## Repository structure

- `/powerbi` – PDF export of the report
- `/screenshots` – model view + dashboard preview
- `/sql` – BigQuery SQL validation queries
- `/docs` – documentation of key DAX measures

---

## Key Findings (from the dashboard)

### 1) Top Selling Categories & Cities

- **Outerwear, coats and jeans dominate revenue.**
- **Clothing Sets** and **Jumpsuits & Rompers** are among the weakest categories.
- Regional revenue distribution shows strong concentration in Asia:

**Revenue by region**
- Asia & Australia: **4,764.87K**
- Americas: **3,996.50K**
- Europe: **2,014.42K**

---

### 2) Purchases by Traffic Source

Purchase share by traffic source:
- Email: **44.92%**
- Adwords: **29.98%**
- YouTube: **10.07%**
- Facebook: **10.01%**
- Organic: **5.03%**

Additionally, the dashboard highlights that **search traffic generates visits without purchases**, indicating a conversion / funnel efficiency gap.

---

### 3) User Value & Market Penetration

KPIs were compared across world regions and selected countries:
- Revenue
- Customers
- Average amount of orders
- Average basket
- Market penetration

Key takeaway:
- Customer value metrics are relatively stable across countries, while **market penetration varies strongly by region**, suggesting growth potential depends more on penetration than on value differences.

---

## DAX Measures (examples)

Core measures used in the report:

**Revenue**
```DAX
Revenue = SUM(order_items[sale_price])
```

**Average Basket (Revenue per Order)**
```DAX
AverageBasket =
DIVIDE(
    [Revenue],
    DISTINCTCOUNT(orders[order_id])
)
```

**Revenue (Completed Orders Only)**
```DAX
Revenue_Completed =
CALCULATE(
    [Revenue],
    orders[status] = "Complete"
)
```

> Additional measures (customer value, order frequency, market penetration, traffic KPIs) were implemented in a dedicated **Measures Table** inside Power BI for clarity and maintainability.

---

## SQL (BigQuery) – validation example

SQL was used to validate KPI logic and ensure consistency between the semantic model and raw data aggregations.

```sql
SELECT
  user_id,
  COUNT(DISTINCT order_id) AS order_count,
  SUM(sale_price) AS lifetime_value
FROM order_items
GROUP BY user_id;
```

---

## Business Recommendations

1. Prioritize marketing investment in high-performing channels (Email, Adwords, YouTube).
2. Investigate the “Search → purchase” funnel and improve conversion mechanics (landing pages, UX, targeting).
3. Rebalance category focus: strengthen top performers and review strategy for structurally weak categories.
4. Use market-penetration differences to guide geographic growth initiatives.

---

## Tools

BigQuery · SQL · Power BI · DAX · Data Modeling · Git
