USE olist_ecommerce;

-- Query 3: Delivery Performance by State
-- Business question: Which states have the best and worst delivery times?
-- Why this query: Identifies geographic bottlenecks in the supply chain

SELECT 
    c.customer_state                                    AS state,
    COUNT(DISTINCT o.order_id)                         AS total_orders,
    ROUND(AVG(
        DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp
        )
    ), 1)                                              AS avg_delivery_days,
    ROUND(MIN(
        DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp
        )
    ), 1)                                              AS fastest_delivery,
    ROUND(MAX(
        DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp
        )
    ), 1)                                              AS slowest_delivery,
    CASE 
        WHEN AVG(DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp)) <= 10 
            THEN 'Fast'
        WHEN AVG(DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp)) <= 15 
            THEN 'Average'
        ELSE 'Slow'
    END                                                AS delivery_category
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
HAVING COUNT(DISTINCT o.order_id) >= 100
ORDER BY avg_delivery_days ASC;