/*
===============================================================================
Problem: LeetCode 196 - Delete Duplicate Emails
Difficulty: Easy
Topics: Database, DML (DELETE), Subqueries, GROUP BY
===============================================================================

Problem Summary:
Delete all duplicate email entries in the Person table, keeping only the 
record with the smallest ID for each unique email address.

Approach:
1. Identify the keeper rows: 
   - Group by email and find the minimum ID (`MIN(id)`).
2. Bypass MySQL Error 1093:
   - In MySQL, you cannot directly reference the target table of a DELETE in a subquery.
   - Wrapping the result inside an intermediate derived table (`AS temp`) creates 
     a temporary table in memory, bypassing this limitation.
3. Delete non-minimum IDs using `WHERE id NOT IN (...)`.
===============================================================================
*/

DELETE FROM Person
WHERE id NOT IN (
    SELECT min_id 
    FROM (
        SELECT MIN(id) AS min_id
        FROM Person
        GROUP BY email
    ) AS temp
);
