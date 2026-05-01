-- ============================================================
-- DISTINCT KEYWORD - REMOVE DUPLICATE VALUES FROM RESULTS
-- ============================================================
-- DISTINCT filters out duplicate rows from query results
-- Shows each unique value only once
-- Useful for finding unique values in a column


-- ============================================================
-- 1. DISTINCT WITH SINGLE COLUMN
-- ============================================================
SELECT DISTINCT first_name 
FROM customer_table;

-- EXPLANATION:
-- - Returns all UNIQUE first_name values from customer_table
-- - Removes duplicate names - each name appears only once
-- - If customer_table has 100 rows with repeated names, returns unique list
-- - ORDER: Results may not be in any particular order
-- - EXAMPLE OUTPUT: John, Sarah, Mike, Lisa (not repeated even if John appears 10 times)
-- - SYNTAX: SELECT DISTINCT [column] FROM [table];
-- - PERFORMANCE: Requires scanning all rows, may be slow on large tables


-- ============================================================
-- 2. DISTINCT WITH WHERE CLAUSE
-- ============================================================
SELECT DISTINCT first_name 
FROM customer_table
WHERE age > 25;

-- EXPLANATION:
-- - Returns unique first_name values only for customers age > 25
-- - WHERE clause filters BEFORE DISTINCT is applied
-- - More efficient: Filters rows first, then removes duplicates
-- - EXAMPLE: Find unique names of customers who are above 25 years old
-- - Can combine any WHERE conditions with DISTINCT
-- - EXAMPLE: SELECT DISTINCT city FROM customers WHERE status = 'Active';


-- ============================================================
-- 3. DISTINCT WITH ORDER BY
-- ============================================================
SELECT DISTINCT first_name 
FROM customer_table
ORDER BY first_name;

-- EXPLANATION:
-- - Returns unique first_name values sorted alphabetically
-- - ORDER BY sorts AFTER DISTINCT is applied
-- - ORDER: ASC (ascending) is default, use DESC for descending
-- - EXAMPLE OUTPUT: Adam, Alex, Andrew, Ben, Brian... (alphabetical, no repeats)
-- - Makes results easier to read and analyze
-- - Sorting can impact performance on large datasets


-- ============================================================
-- 4. DISTINCT WITH MULTIPLE COLUMNS
-- ============================================================
SELECT DISTINCT first_name, last_name 
FROM customer_table;

-- EXPLANATION:
-- - Returns unique COMBINATIONS of first_name and last_name
-- - John Smith appears once, even if 5 customers have this name
-- - Uniqueness is based on COMBINATION of all columns, not individual
-- - EXAMPLE: If you have:
--   John Smith (3 times)
--   John Brown (2 times)
--   Sarah Smith (1 time)
-- - Result: 3 unique combinations (John Smith, John Brown, Sarah Smith)
-- - USEFUL: Find unique customer full names
-- - Each row in result is distinct (all columns together are unique)


-- ============================================================
-- 5. DISTINCT WITH 3+ COLUMNS
-- ============================================================
SELECT DISTINCT first_name, last_name, city 
FROM customer_table;

-- EXPLANATION:
-- - Returns unique COMBINATIONS of three columns
-- - John Smith from New York appears once
-- - John Smith from Los Angeles appears separately (different city)
-- - Uniqueness based on: (first_name + last_name + city) combination
-- - EXAMPLE:
--   John Smith, New York (counted once)
--   John Smith, Los Angeles (counted once - different from above)
--   John Smith, New York (duplicate - not repeated)
-- - More columns = More unique combinations
-- - Useful for: Finding unique customer locations, branches, departments, etc.


-- ============================================================
-- 6. COUNT DISTINCT - COUNT UNIQUE VALUES
-- ============================================================
SELECT COUNT(DISTINCT first_name) 
FROM customer_table;

-- EXPLANATION:
-- - Counts how many UNIQUE first_name values exist
-- - Ignores duplicates in the count
-- - Returns single number: count of distinct names
-- - EXAMPLE: If customer_table has 100 rows but only 25 unique names
--   Result: 25 (not 100)
-- - SYNTAX: SELECT COUNT(DISTINCT [column]) FROM [table];
-- - USEFUL FOR: 
--   How many unique customers? COUNT(DISTINCT cust_id)
--   How many unique products? COUNT(DISTINCT product_id)
--   How many cities do we serve? COUNT(DISTINCT city)


-- ============================================================
-- 7. COUNT DISTINCT WITH MULTIPLE COLUMNS
-- ============================================================
SELECT COUNT(DISTINCT first_name, last_name) 
FROM customer_table;

-- EXPLANATION:
-- - Counts unique COMBINATIONS of first_name and last_name
-- - Each unique full name counted once
-- - If multiple rows have "John Smith", counts as 1
-- - EXAMPLE: If 100 customer rows but only 45 unique full names
--   Result: 45
-- - USEFUL: How many unique customers by name (allows duplicate first/last names separately)
-- - Note: Syntax may vary by database (some use: COUNT(DISTINCT CONCAT(first_name,' ',last_name)))


-- ============================================================
-- 8. DISTINCT WITH GROUP BY ALTERNATIVE
-- ============================================================
-- These two queries produce similar results:

-- Using DISTINCT:
SELECT DISTINCT city 
FROM customer_table;

-- Using GROUP BY (alternative):
SELECT city 
FROM customer_table
GROUP BY city;

-- EXPLANATION:
-- - Both return unique city values
-- - DISTINCT: Simpler syntax, used just for uniqueness
-- - GROUP BY: More powerful, can aggregate (COUNT, SUM, AVG, etc.)
-- - PERFORMANCE: GROUP BY often faster on large datasets
-- - WHEN TO USE DISTINCT: Just need unique values, no aggregation
-- - WHEN TO USE GROUP BY: Need unique values + aggregation
-- - EXAMPLE GROUP BY:
--   SELECT city, COUNT(*) as customer_count 
--   FROM customer_table 
--   GROUP BY city;
--   (Shows each city with count of customers)


-- ============================================================
-- 9. DISTINCT ON (PostgreSQL specific)
-- ============================================================
-- PostgreSQL only - not standard SQL
-- SELECT DISTINCT ON (first_name) first_name, last_name 
-- FROM customer_table
-- ORDER BY first_name, created_date DESC;

-- EXPLANATION (PostgreSQL):
-- - Keeps first occurrence of each first_name (based on ORDER BY)
-- - Returns one first_name value, plus associated last_name
-- - ORDER BY determines which row is "first"
-- - UNIQUE BY: Unique based on first_name column only
-- - USEFUL: Get latest record per customer, one sample per group
-- - Not available in SQL Server, MySQL (use ROW_NUMBER() instead)


-- ============================================================
-- 10. DISTINCT WITH NULL VALUES
-- ============================================================
SELECT DISTINCT middle_name 
FROM customer_table;

-- EXPLANATION:
-- - If column has NULL values, NULL appears once in results
-- - NULL is treated as a value for DISTINCT purposes
-- - All NULL values are treated as equal
-- - EXAMPLE RESULTS:
--   John (appears once even if 5 rows have 'John')
--   Michael (appears once even if 3 rows have 'Michael')
--   NULL (appears once, representing all NULL rows)
-- - Useful: Identify if NULL values exist in column
-- - Can filter NULLs: WHERE middle_name IS NOT NULL


-- ============================================================
-- COMMON USE CASES
-- ============================================================

-- 1. Find all unique product categories
-- SELECT DISTINCT category FROM products;

-- 2. How many different countries have customers?
-- SELECT COUNT(DISTINCT country) FROM customers;

-- 3. List all unique cities our customers are located in
-- SELECT DISTINCT city FROM customers ORDER BY city;

-- 4. Find customers with first name 'John' and see how many are in database
-- SELECT COUNT(DISTINCT cust_id) FROM customers WHERE first_name = 'John';

-- 5. Get unique email addresses that are active
-- SELECT DISTINCT email FROM users WHERE status = 'Active';

-- 6. Find unique product combinations ordered by customer
-- SELECT DISTINCT customer_id, product_id FROM orders ORDER BY customer_id;

-- 7. How many unique sales representatives do we have?
-- SELECT COUNT(DISTINCT sales_rep_id) FROM sales;

-- 8. Find all unique payment methods
-- SELECT DISTINCT payment_method FROM transactions WHERE year = 2026;

-- 9. Get one sample customer per city
-- SELECT DISTINCT ON (city) customer_name, city FROM customers ORDER BY city;

-- 10. List unique job titles and their count
-- SELECT job_title, COUNT(*) FROM employees GROUP BY job_title;


-- ============================================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================================

-- 1. DISTINCT can be slow
--    - Must process all rows and compare
--    - Large datasets = longer execution time
--    - Create indexes on DISTINCT columns

-- 2. Avoid DISTINCT on very wide rows
--    - Comparing multiple columns requires more memory
--    - Example: DISTINCT on 10 columns slower than DISTINCT on 1 column

-- 3. Use WHERE clause first
--    - Filter rows BEFORE applying DISTINCT
--    - Example: WHERE status = 'Active' first, then DISTINCT
--    - Reduces data volume before deduplication

-- 4. INDEX the DISTINCT columns
--    - CREATE INDEX idx_first_name ON customer_table(first_name);
--    - Speeds up DISTINCT queries on indexed columns

-- 5. GROUP BY alternative for large datasets
--    - Often faster: SELECT city FROM customers GROUP BY city;
--    - vs DISTINCT: SELECT DISTINCT city FROM customers;

-- 6. Limit results when possible
--    - SELECT DISTINCT city FROM customers LIMIT 100;
--    - Stops once 100 unique values found

-- 7. Consider materialized view for repeated queries
--    - Create view if same DISTINCT query runs frequently
--    - Results cached, executes faster


-- ============================================================
-- DISTINCT VS UNIQUE - TERMINOLOGY
-- ============================================================

-- DISTINCT (SQL keyword):
-- - Used in SELECT statements
-- - Removes duplicate rows from results
-- - Example: SELECT DISTINCT city FROM customers;

-- UNIQUE (Constraint):
-- - Database constraint on a column
-- - Prevents duplicate values being inserted
-- - Example: ALTER TABLE customers ADD CONSTRAINT UQ_Email UNIQUE (email);

-- These are different concepts:
-- - DISTINCT: Query result filtering
-- - UNIQUE: Data integrity constraint


-- ============================================================
-- BEST PRACTICES
-- ============================================================

-- 1. Use DISTINCT only when needed
--    - Adds processing overhead
--    - If you don't need uniqueness, don't use it

-- 2. Always use WHERE to filter first
--    - SELECT DISTINCT status FROM customers WHERE active = 1;
--    - vs SELECT DISTINCT status FROM customers;

-- 3. Document why DISTINCT is used
--    - Comments explain business purpose
--    - Example: -- Get unique regions for regional analysis

-- 4. Test performance on large tables
--    - DISTINCT on big tables may be slow
--    - Consider GROUP BY or indexes

-- 5. Use LIMIT for initial testing
--    - SELECT DISTINCT city FROM customers LIMIT 10;
--    - See results quickly before running full query

-- 6. Order results for readability
--    - SELECT DISTINCT city FROM customers ORDER BY city;
--    - Easier to scan and review

-- 7. Use COUNT(DISTINCT x) for counts
--    - More efficient than: SELECT COUNT(*) FROM (SELECT DISTINCT x FROM table) sub;
--    - Simpler and clearer: SELECT COUNT(DISTINCT x) FROM table;

-- 8. Consider data types
--    - DISTINCT on numbers is different from text
--    - '1' and 1 may be treated as different

-- 9. Be aware of case sensitivity
--    - Database settings determine if 'John' and 'JOHN' are unique
--    - SQL Server: Case insensitive by default
--    - PostgreSQL: Case sensitive by default

-- 10. Document NULL handling
--     - NULL values appear once in DISTINCT results
--     - Comment on expected NULL behavior


