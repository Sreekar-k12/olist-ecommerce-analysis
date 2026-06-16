USE olist_ecommerce;

-- Query 2: Top 10 Product Categories by Revenue
-- Business question: Which categories drive the most revenue?
-- Why this query: Category performance guides seller acquisition strategy

SELECT 
    ct.product_category_name_english  AS category,
    COUNT(DISTINCT oi.order_id)       AS total_orders,
    ROUND(SUM(oi.price), 2)           AS total_revenue,
    ROUND(AVG(oi.price), 2)           AS avg_item_price
FROM order_items oi
JOIN products p         ON oi.product_id = p.product_id
JOIN category_translation ct ON p.product_category_name = ct.product_category_name
WHERE oi.order_id IN (
    SELECT order_id FROM orders 
    WHERE order_status = 'delivered'
)
GROUP BY ct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;