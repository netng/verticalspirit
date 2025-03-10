-- Query
SELECT u.name AS user, b.name AS book, b.date
FROM books b
JOIN users u ON b.user_id = u.id
WHERE b.date = (
  SELECT MAX(date) FROM books WHERE user_id = b.user_id
);

-- Result :
/*
user   |book                                    |date      |
-------+----------------------------------------+----------+
John   |Associate Degree in Information¶¶Systems|2019-07-07|
Bob    |Bachelor of Psychology                  |2019-06-06|
Britany|Associate Degree in Health Science      |2019-04-04|
*/


-- Data example

-- Table : users
/*
id                                  |name   |mark|created_at             |updated_at             |
------------------------------------+-------+----+-----------------------+-----------------------+
bd747d68-0c90-428b-a11c-78c8c825aa12|John   |A   |2025-03-10 16:39:10.691|2025-03-10 16:39:10.691|
18a3547f-345b-4b55-9779-82067eeac7fe|Marissa|B   |2025-03-10 16:39:21.938|2025-03-10 16:39:21.938|
508c3cc2-474e-40c1-abf8-f2b68dd37430|Bob    |C   |2025-03-10 16:39:30.565|2025-03-10 16:39:30.565|
214a11b2-04e0-447b-bbe9-7b7b2cd35f97|Britany|C   |2025-03-10 16:39:46.683|2025-03-10 16:39:46.683|
*/

-- Table : books
/*
id                                  |name                                    |date      |user_id                             |created_at             |updated_at             |
------------------------------------+----------------------------------------+----------+------------------------------------+-----------------------+-----------------------+
30aea3b5-6a4f-4147-985f-0eaede0b4096|Bachelor of Information Systems         |2019-01-01|bd747d68-0c90-428b-a11c-78c8c825aa12|2025-03-10 16:57:30.930|2025-03-10 16:57:30.930|
94ede2a0-18e5-4ce3-a9b8-9add63ce8ca9|Bachelor of Design                      |2019-02-02|508c3cc2-474e-40c1-abf8-f2b68dd37430|2025-03-10 16:58:51.029|2025-03-10 16:58:51.029|
c3319c1f-682b-4333-a8b1-bee9f5974810|Bachelor of Commerce                    |2019-03-03|214a11b2-04e0-447b-bbe9-7b7b2cd35f97|2025-03-10 16:59:40.360|2025-03-10 16:59:40.360|
12575278-4c3f-4c5a-b136-e10c995e8aaa|Associate Degree in Health Science      |2019-04-04|214a11b2-04e0-447b-bbe9-7b7b2cd35f97|2025-03-10 17:00:04.083|2025-03-10 17:00:04.083|
1f537b10-9e6d-472f-b080-e3938d6ad65f|Master of Architectural Technology      |2019-05-05|508c3cc2-474e-40c1-abf8-f2b68dd37430|2025-03-10 17:00:34.203|2025-03-10 17:00:34.203|
68aea730-6ee7-4c24-bc67-5a006db35c05|Bachelor of Psychology                  |2019-06-06|508c3cc2-474e-40c1-abf8-f2b68dd37430|2025-03-10 17:00:53.077|2025-03-10 17:00:53.077|
c9a2185d-496b-4e6b-aead-4dc23e9a4d07|Associate Degree in Information¶¶Systems|2019-07-07|bd747d68-0c90-428b-a11c-78c8c825aa12|2025-03-10 17:01:14.350|2025-03-10 17:01:14.350|
*/

