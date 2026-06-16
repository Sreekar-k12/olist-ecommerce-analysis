USE olist_ecommerce;

-- Query 1: Monthly Revenue Analysis
-- Business question: How did revenue trend month by month?

SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS `year_month`,
    COUNT(DISTINCT o.order_id)                     AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2)     AS total_revenue,
    ROUND(AVG(oi.price + oi.freight_value), 2)     AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY `year_month`
ORDER BY `year_month` ASC;