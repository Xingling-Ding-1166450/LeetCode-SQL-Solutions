/*
Problem: LeetCode 1174 - Immediate Food Delivery II
Key learning: IFNULL only works on existing rows, not on empty results.
Also: AVG(condition) is the SQL equivalent of COUNTIF() / COUNT().
*/

WITH ranked_orders AS (
    SELECT 
        customer_id, 
        order_date, 
        customer_pref_delivery_date,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id ORDER BY order_date ASC
        ) AS rn
    FROM Delivery
)

SELECT 
    ROUND(AVG(order_date = customer_pref_delivery_date) * 100, 2) 
        AS immediate_percentage
FROM ranked_orders
WHERE rn = 1;
