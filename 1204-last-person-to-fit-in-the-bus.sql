/*
Problem: LeetCode 1204 - Last Person to Fit in the Bus
Difficulty: Medium
Dialect: MySQL 8.0+

My approach:
1. Calculate the running total of weight in boarding order (`turn`).
2. Keep only the rows where the total weight does not exceed 1000.
3. Return the last person among those rows.
*/

with mytable as (select *, sum(weight) over(order by turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS total_weight
from queue
order by turn)

select person_name from  mytable
where total_weight <= 1000
order by total_weight desc
limit 1
