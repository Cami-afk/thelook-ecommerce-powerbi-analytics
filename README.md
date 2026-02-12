# The Look E-commerce – BI Analysis (Power BI + BigQuery)

[![Power BI interactive report](https://img.shields.io/badge/PowerBI-Live%20Dashboard-yellow?logo=powerbi)](https://app.powerbi.com/view?r=eyJrIjoiMmRhMGYwMjktYzY1OS00MTFiLWJmMWYtOTc0ZjZkN2Y1OWRjIiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9)

**Power BI · DAX · BigQuery · SQL · Data Modeling**

## Business Context

This project uses multi-table e-commerce data (orders, order items, products, users, events, inventory and distribution centers) to identify revenue drivers, marketing channel effectiveness and geographic differences in performance.

The dashboard was designed as an executive-friendly decision tool with drill-down capability across:
- product categories and cities
- traffic sources and purchase behavior
- customer value and market penetration by region

Dataset: https://www.kaggle.com/datasets/mustafakeser4/looker-ecommerce-bigquery-dataset

---

## Data Model

The Power BI model follows a star-schema logic:

**Fact tables**
- `order_items` (sales at item level)
- `orders` (order-level attributes, status, timestamps)
- `events` (web activity / traffic source)

**Dimension tables**
- `products` (category, brand, retail_price)
- `users` (geo, demographics, traffic_source)
- `distribution_centers` (geo)
- `calendar` (date table created via `CALENDARAUTO()`)

Relationships were configured to support:
- revenue aggregation by category, city and region
- user-level analysis and geographic drill-down
- comparison of traffic sources vs. purchases

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

SQL was used to validate key aggregations and customer-level metrics before final visualization.

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
