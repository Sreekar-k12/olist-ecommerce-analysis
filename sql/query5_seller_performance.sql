USE olist_ecommerce;

-- Query 5: Seller Performance Analysis
-- Business question: Who are the top performing sellers and what makes them good?
-- Why this query: Identifies best sellers by revenue AND satisfaction
-- This is a BA-flavoured query — it combines operational data with 
-- customer feedback to produce a business recommendation

SELECT 
    s.seller_id,
    s.seller_city,
    s.seller_state,
    COUNT(DISTINCT oi.order_id)             AS total_orders,
    ROUND(SUM(oi.price), 2)                 AS total_revenue,
    ROUND(AVG(oi.price), 2)                 AS avg_item_price,
    ROUND(AVG(r.review_score), 2)           AS avg_review_score,
    ROUND(AVG(
        DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp
        )
    ), 1)                                   AS avg_delivery_days,
    CASE
        WHEN AVG(r.review_score) >= 4.5 
         AND SUM(oi.price) >= 10000
            THEN 'Star Seller'
        WHEN AVG(r.review_score) >= 4.0 
         AND SUM(oi.price) >= 5000
            THEN 'Good Seller'
        WHEN AVG(r.review_score) < 3.0
            THEN 'Needs Improvement'
        ELSE 
            'Average Seller'
    END                                     AS seller_category
FROM sellers s
JOIN order_items oi  ON s.seller_id = oi.seller_id
JOIN orders o        ON oi.order_id = o.order_id
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY s.seller_id, s.seller_city, s.seller_state
HAVING COUNT(DISTINCT oi.order_id) >= 10
ORDER BY total_revenue DESC
LIMIT 20;