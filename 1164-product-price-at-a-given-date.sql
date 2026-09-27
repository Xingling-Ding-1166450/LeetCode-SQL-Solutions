/*
===============================================================================
Problem: LeetCode 1164 - Product Price at a Given Date
Difficulty: Medium
Topics: Database, Subqueries, GROUP BY, HAVING, UNION
===============================================================================

Problem Summary:
Find the prices of all products on '2019-08-16'. 
Assume the initial price of all products before any change is 10.

Key Insights:
1. Products with price changes ON or BEFORE 2019-08-16:
   - We need their most recent price (MAX change_date <= '2019-08-16').
   - We match the locked pair (product_id, change_date) to ensure we pick 
     the price corresponding to the latest change.

2. Products with NO price changes on or before 2019-08-16:
   - Their first recorded change happened AFTER the cutoff date.
   - We identify them using HAVING MIN(change_date) > '2019-08-16'.
   - Why HAVING instead of WHERE? 
     Using WHERE would filter out past history per row. HAVING inspects the 
     entire timeline of the product to ensure 100% of its changes are in the future.
   - These products get the default price of 10.

3. UNION:
   - Combines both groups into a single distinct result set.
===============================================================================
*/

-- 1. Products that had at least one price change on or before 2019-08-16
SELECT 
    product_id, 
    new_price AS price
FROM Products
WHERE (product_id, change_date) IN (
    SELECT 
        product_id, 
        MAX(change_date)
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
)

UNION

-- 2. Products whose very first price change happened after 2019-08-16 (default price = 10)
SELECT 
    product_id, 
    10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16';
