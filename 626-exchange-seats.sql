/*
Problem: LeetCode 626 - Exchange Seats
Difficulty: Medium
Dialect: MySQL 8.0+

Approach:
Swap each pair of adjacent students. For every row, decide whether to pull the
name from the next row or the previous row based on its position in the queue.

- Odd position  -> take the NEXT student  (LEAD)
- Even position -> take the PREVIOUS student (LAG)

Two details worth noting:

1. ROW_NUMBER() instead of id % 2
   Using id % 2 assumes ids are continuous integers starting at 1. ROW_NUMBER()
   asks "is this the 1st/2nd/3rd row?" instead, so the pairing stays correct
   even if the ids have gaps (e.g. 1, 2, 5, 7, 9).

2. IFNULL on the LEAD branch
   When the number of students is odd, the last student has no next row, so
   LEAD returns NULL. IFNULL falls back to the student's own name so they
   keep their seat instead of disappearing.
*/

SELECT ID,
CASE WHEN
         ROW_NUMBER() OVER(ORDER BY ID) %2 = 1 THEN IFNULL(LEAD(STUDENT) OVER(ORDER BY ID),STUDENT)
      ELSE LAG(STUDENT) OVER (ORDER BY ID)
END AS student
FROM SEAT
      
