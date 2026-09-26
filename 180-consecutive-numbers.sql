/*
Problem: LeetCode 180 - Consecutive Numbers
Difficulty: Medium
Runtime: 521 ms (Beats 96.68%)

Approach: Chain two CTEs with LAG()
- CTE 1: Detects if current num equals previous num (streak of 2+)
- CTE 2: Detects if CTE1 result equals previous CTE1 result (streak of 3+)
- Filter: Only keep non-NULL rows where 3 consecutive matches exist
*/

with logtable as (select id,
      case when
               num = lag(num) over (order by id) then num
            end as num
from logs),

log2 as (Select 
      case when
               num = lag(num) over (order by id) then num
            end as num2 
from logtable)

select distinct num2 as ConsecutiveNums from log2 
where num2 is not null
