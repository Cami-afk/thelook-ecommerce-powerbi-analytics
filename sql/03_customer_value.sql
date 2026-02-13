-- Customer lifetime value (revenue and order frequency per user)
SELECT
  ord.user_id,
  COUNT(DISTINCT ord.order_id) AS order_count,
  SUM(ord_itm.sale_price) AS lifetime_revenue
FROM orders ord
JOIN order_items ord_itm 
  ON ord_itm.order_id = ord.order_id
GROUP BY ord.user_id
ORDER BY lifetime_revenue DESC;
