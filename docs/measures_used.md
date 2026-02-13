# Core DAX Measures – Business & Technical Definition

## Key Measures Used in the Report

This document summarizes the main KPIs implemented in the Power BI model.
Each measure is described from a business perspective. Their DAX definitions follow.

- Revenue : Total gross sales value (item-level).
- Revenue (Completed Orders) : Revenue limited to completed transactions.
- Average Basket (Revenue per Order) : Revenue per order.
- Order Count : Number of distinct orders.
- Average Sale Price : Average item-level sale price.
- Customers (Distinct users) : Distinct purchasing users.
- Average Orders per Customer : Order frequency per customer.
- Market Penetration : Customers relative to country population.



## DAX Definitions  

### Revenue
```DAX
Revenue =
SUM(order_items[sale_price])
```

### Revenue (Completed Orders Only)
```DAX:
Revenue_Completed =
CALCULATE(
    [Revenue],
    orders[status] = "Complete"
)
```

### Order Count
```DAX
OrderCount =
DISTINCTCOUNT(orders[order_id])
```

### Average Basket
```DAX
AverageBasket =
DIVIDE(
    [Revenue],
    [OrderCount]
)
```

### Average Sale Price
```DAX
AverageSalePrice =
AVERAGE(order_items[sale_price])
```

### Customers
```DAX
Customers =
DISTINCTCOUNT(orders[user_id])
```

### Average Orders per Customer
```DAX
AverageOrderCount =
DIVIDE(
    [OrderCount],
    [Customers]
)
```

### Market Penetration
```DAX
MarketPenetration =
DIVIDE(
    [Customers],
    SUM(Countries[Population])
)
```
## Geography
- CountryPopulation (reference table)
- Market Penetration (Customers vs. population)
