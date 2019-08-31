-- SELECT 
--     CONCAT(
--         SUBSTRING(title, 1, 10), 
--         "..."
--     ) AS "short title"
-- FROM books;

SELECT
    REPLACE(title, "s", "7")
FROM books;