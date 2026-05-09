-- ============================================================
-- LIMIT CLAUSE - RESTRICTING RESULT SET SIZE
-- ============================================================
-- The LIMIT clause is used to restrict the number of rows returned by a query.
-- Syntax: SELECT columns FROM table [WHERE conditions] [ORDER BY] LIMIT number;
-- Useful for: Pagination, top N results, performance optimization

-- ============================================================
-- EXAMPLE 1: LIMIT WITH ORDER BY DESCENDING
-- ============================================================
SELECT *
FROM customer
WHERE age > 25
ORDER BY age DESC
LIMIT 8;

-- EXPLANATION:
-- - WHERE age > 25: Filters customers older than 25
-- - ORDER BY age DESC: Sorts by age in descending order (oldest first)
-- - LIMIT 8: Returns only the first 8 rows from the sorted result
-- - Results: Top 8 oldest customers over 25 years old

-- ============================================================
-- EXAMPLE 2: LIMIT WITH ORDER BY ASCENDING
-- ============================================================
SELECT *
FROM customer
WHERE age > 25
ORDER BY age
LIMIT 11;

-- EXPLANATION:
-- - WHERE age > 25: Filters customers older than 25
-- - ORDER BY age: Sorts by age in ascending order (youngest first)
-- - LIMIT 11: Returns only the first 11 rows from the sorted result
-- - Results: 11 youngest customers over 25 years old

-- ============================================================
-- LIMIT CLAUSE NOTES
-- ============================================================
-- - LIMIT is typically used with ORDER BY to get "top N" results
-- - Without ORDER BY, LIMIT returns first N rows (order not guaranteed)
-- - LIMIT is processed after WHERE and ORDER BY clauses
-- - Useful for pagination: LIMIT 10 OFFSET 20 (get rows 21-30)
-- - Performance: LIMIT can improve query speed by stopping early
-- - Database specific: Some databases use TOP instead of LIMIT (SQL Server)