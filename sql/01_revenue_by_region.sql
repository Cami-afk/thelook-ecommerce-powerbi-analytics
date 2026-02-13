-- Revenue by region (based on users country)
SELECT
  usrs.country,
  SUM(ord_itm.sale_price) AS revenue
FROM order_items ord_itm
JOIN orders ord ON ord_itm.order_id = ord.order_id
JOIN users usrs ON ord.user_id = usrs.id
GROUP BY usrs.country
ORDER BY revenue DESC;
