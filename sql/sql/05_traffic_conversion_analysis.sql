-- Traffic source performance: users, buyers and revenue

WITH traffic_users AS (
    SELECT
        usrs.traffic_source,
        COUNT(DISTINCT ev.user_id) AS visitors
    FROM events ev
    JOIN users usrs
        ON ev.user_id = usrs.id
    GROUP BY usrs.traffic_source
),

purchasing_users AS (
    SELECT
        usrs.traffic_source,
        COUNT(DISTINCT ord.user_id) AS buyers,
        COUNT(DISTINCT ord.order_id) AS orders,
        SUM(ord_itm.sale_price) AS revenue
    FROM orders ord
    JOIN order_items ord_itm
        ON ord.order_id = ord_itm.order_id
    JOIN users usrs
        ON ord.user_id = usrs.id
    GROUP BY usrs.traffic_source
)

SELECT
    tr_usrs.traffic_source,
    tr_usrs.visitors,
    COALESCE(pur_usrs.buyers, 0) AS buyers,
    COALESCE(pur_usrs.orders, 0) AS orders,
    COALESCE(pur_usrs.revenue, 0) AS revenue,
    SAFE_DIVIDE(pur_usrs.buyers, tr_usrs.visitors) AS conversion_rate
FROM traffic_users tr_usrs
LEFT JOIN purchasing_users pur_usrs
    ON tr_usrs.traffic_source = pur_usrs.traffic_source
ORDER BY revenue DESC;
