-- Query
WITH mark_counts AS (
  SELECT mark, COUNT(*) AS count FROM users GROUP BY mark
),
combined AS (
  SELECT mark, count FROM mark_counts
  UNION ALL
  SELECT 'A+B', (SELECT SUM(count) FROM mark_counts WHERE mark IN ('A', 'B'))
  UNION ALL
  SELECT 'A+C', (SELECT SUM(count) FROM mark_counts WHERE mark IN ('A', 'C'))
  UNION ALL
  SELECT 'B+C', (SELECT SUM(count) FROM mark_counts WHERE mark IN ('B', 'C'))
  UNION ALL
  SELECT 'A+B+C', (SELECT SUM(count) FROM mark_counts WHERE mark IN ('A', 'B', 'C'))
)
SELECT * FROM combined
ORDER BY 
  CASE 
    WHEN mark = 'A' THEN 1
    WHEN mark = 'B' THEN 2
    WHEN mark = 'C' THEN 3
    WHEN mark = 'A+B' THEN 4
    WHEN mark = 'A+C' THEN 5
    WHEN mark = 'B+C' THEN 6
    WHEN mark = 'A+B+C' THEN 7
  END;

-- result :
/*
mark |count|
-----+-----+
A    |    1|
B    |    1|
C    |    2|
A+B  |    2|
A+C  |    3|
B+C  |    3|
A+B+C|    4|
*/


-- Data example :
/*
id                                  |name   |mark|created_at             |updated_at             |
------------------------------------+-------+----+-----------------------+-----------------------+
bd747d68-0c90-428b-a11c-78c8c825aa12|John   |A   |2025-03-10 16:39:10.691|2025-03-10 16:39:10.691|
18a3547f-345b-4b55-9779-82067eeac7fe|Marissa|B   |2025-03-10 16:39:21.938|2025-03-10 16:39:21.938|
508c3cc2-474e-40c1-abf8-f2b68dd37430|Bob    |C   |2025-03-10 16:39:30.565|2025-03-10 16:39:30.565|
214a11b2-04e0-447b-bbe9-7b7b2cd35f97|Britany|C   |2025-03-10 16:39:46.683|2025-03-10 16:39:46.683|
*/

