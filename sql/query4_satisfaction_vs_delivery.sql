USE olist_ecommerce;

-- Query 4: Customer Satisfaction vs Delivery Speed
-- Business question: Does delivery speed directly impact review scores?
-- Why this query: Proves the link between operations and customer experience
-- This is your strongest business insight — backed by SQL evidence

SELECT 
    CASE 
        WHEN DATEDIFF(o.order_delivered_customer_date, 
                      o.order_purchase_timestamp) <= 7  
            THEN '1 - Fast (<=7 days)'
        WHEN DATEDIFF(o.order_delivered_customer_date, 
                      o.order_purchase_timestamp) <= 14 
            THEN '2 - Normal (8-14 days)'
        WHEN DATEDIFF(o.order_delivered_customer_date, 
                      o.order_purchase_timestamp) <= 21 
            THEN '3 - Slow (15-21 days)'
        ELSE 
            '4 - Very Slow (>21 days)'
    END                                         AS delivery_speed,
    COUNT(DISTINCT o.order_id)                  AS total_orders,
    ROUND(AVG(r.review_score), 2)               AS avg_review_score,
    ROUND(MIN(r.review_score), 2)               AS min_score,
    ROUND(MAX(r.review_score), 2)               AS max_score,
    SUM(CASE WHEN r.review_score = 5 
             THEN 1 ELSE 0 END)                 AS five_star_count,
    SUM(CASE WHEN r.review_score = 1 
             THEN 1 ELSE 0 END)                 AS one_star_count
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_speed
ORDER BY delivery_speed ASC;