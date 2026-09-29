/*
===============================================================================
Problem: LeetCode 176 - Second Highest Salary
Difficulty: Medium
Topics: Database, Subqueries, Aggregate Functions
===============================================================================

Problem Summary:
Find the second highest distinct salary from the Employee table.
If there is no second highest salary, return NULL.

Approach (Optimal - O(N) Two-Scan Filter):
1. Subquery: Find the absolute maximum salary: `SELECT MAX(salary) FROM Employee`.
2. Filter: Use `WHERE salary < (MAX)` to exclude all instances of the highest salary 
   (handles ties in 1st place automatically).
3. Aggregate: Find the new `MAX(salary)` among remaining records.
   - If there are duplicate 2nd-place salaries, `MAX()` collapses them to a single value.
   - If no salaries remain (table has only 1 distinct salary), `MAX()` evaluates 
     over an empty set and naturally returns `NULL`.

Why this is better than ORDER BY / DENSE_RANK:
- Avoids expensive sorting operations ($O(N \log N)$), running in linear time ($O(N)$).
- Avoids empty-result set traps with LIMIT / OFFSET.
===============================================================================
*/

SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (
    SELECT MAX(salary) 
    FROM Employee
);
