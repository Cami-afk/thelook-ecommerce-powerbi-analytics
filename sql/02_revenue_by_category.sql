-- Revenue by product category
SELECT
  prd.category,
  SUM(ord_itm.sale_price) AS revenue,
  COUNT(DISTINCT ord_itm.order_id) AS orders
FROM order_items ord_itm
JOIN products prd 
  ON ord_itm.product_id = prd.id
GROUP BY prd.category
ORDER BY revenue DESC;
