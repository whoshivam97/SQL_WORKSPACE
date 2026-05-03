
-- ============================================================
-- SELECT STATEMENT - RETRIEVE DATA FROM TABLE
-- ============================================================
-- SELECT is the most fundamental SQL command
-- Used to retrieve/query data from one or more tables
-- Syntax: SELECT columns FROM table [WHERE conditions] [ORDER BY] [LIMIT];


-- ============================================================
-- 1. SELECT SINGLE COLUMN
-- ============================================================
SELECT first_name 
FROM customer_table;

-- EXPLANATION:
-- - SELECT first_name: Retrieves only the first_name column
-- - FROM customer_table: From which table to fetch data
-- - Returns: One column with all first names from the table
-- - No WHERE clause: Returns ALL rows in the table
-- - Results show only names, no other information

-- EXAMPLE OUTPUT:
-- | first_name |
-- |-----------|
-- | John      |
-- | Sarah     |
-- | Michael   |
-- | David     |
-- | Emma      |
-- (All 1000 rows if 1000 customers exist)

-- WHEN TO USE:
-- - Need only one piece of information
-- - Reduce data transfer (smaller result set)
-- - Performance: Faster than SELECT *
-- - Memory: Uses less memory
-- - Clarity: Shows focused data

-- SYNTAX:
-- SELECT column_name FROM table_name;

-- VARIATIONS:
-- SELECT id FROM customers;
-- SELECT email FROM users;
-- SELECT product_name FROM products;

-- PERFORMANCE NOTE:
-- - Single column: Very fast
-- - Works with large tables efficiently
-- - Column should ideally be indexed


-- ============================================================
-- 2. SELECT ALL COLUMNS USING *
-- ============================================================
SELECT * 
FROM customer_table;

-- EXPLANATION:
-- - SELECT *: The * (asterisk) is a wildcard meaning "all columns"
-- - Retrieves EVERY column from the table
-- - FROM customer_table: Source table
-- - Returns: All columns and all rows
-- - Convenient but often not best practice

-- TABLE STRUCTURE (ASSUMED):
-- | customer_id | first_name | last_name | age | email          |
-- |------------|-----------|-----------|-----|----------------|
-- | 1          | John      | Smith     | 25  | john@email.com |
-- | 2          | Sarah     | Johnson   | 30  | sarah@email.com|
-- | 3          | Michael   | Brown     | 35  | michael@...    |

-- EXAMPLE OUTPUT:
-- | customer_id | first_name | last_name | age | email          |
-- |------------|-----------|-----------|-----|----------------|
-- | 1          | John      | Smith     | 25  | john@email.com |
-- | 2          | Sarah     | Johnson   | 30  | sarah@email.com|
-- | 3          | Michael   | Brown     | 35  | michael@...    |
-- (All columns for all rows)

-- WHEN TO USE:
-- - Exploring data (initial investigation)
-- - Testing/debugging queries
-- - Data validation
-- - Small tables
-- - Need all information

-- WHEN NOT TO USE (AVOID):
-- - Production code: Performance risk
-- - Large tables: Too much data transferred
-- - Wide tables (many columns): Unnecessary overhead
-- - Specific needs: Wastes bandwidth
-- - Documentation: Unclear intent

-- SYNTAX:
-- SELECT * FROM table_name;

-- DISADVANTAGES OF SELECT *:
-- 1. PERFORMANCE: Retrieves unnecessary columns
-- 2. BANDWIDTH: Transfers more data across network
-- 3. MEMORY: Uses more memory on client side
-- 4. CLARITY: Doesn't show code intent
-- 5. MAINTENANCE: If table structure changes, unexpected columns added
-- 6. INDEX: Can't use index-only scan optimization

-- EXAMPLE OF PROBLEM:
-- Table has 20 columns, but you only need 2
-- SELECT * FROM users; (transfers 18 unnecessary columns)
-- SELECT name, email FROM users; (transfers only needed 2)

-- BETTER PRACTICE:
-- Instead of: SELECT * FROM customer_table;
-- Use: SELECT customer_id, first_name, last_name, age, email FROM customer_table;


-- ============================================================
-- 3. SELECT MULTIPLE SPECIFIC COLUMNS
-- ============================================================
SELECT first_name, last_name 
FROM customer_table;

-- EXPLANATION:
-- - SELECT first_name, last_name: Retrieves two specific columns
-- - Columns separated by commas
-- - FROM customer_table: Source table
-- - Returns: Only first and last names
-- - Order in SELECT matches output column order

-- COLUMN ORDERING:
-- SELECT first_name, last_name - Output has first_name then last_name
-- SELECT last_name, first_name - Output has last_name then first_name
-- SELECT order matters for result display

-- EXAMPLE OUTPUT:
-- | first_name | last_name |
-- |-----------|-----------|
-- | John      | Smith     |
-- | Sarah     | Johnson   |
-- | Michael   | Brown     |
-- | David     | Lee       |
-- | Emma      | Wilson    |

-- WHEN TO USE:
-- - Most common approach
-- - Retrieve specific needed columns
-- - Improve performance
-- - Reduce data transfer
-- - Clear code intent
-- - BEST PRACTICE

-- SYNTAX:
-- SELECT column1, column2, column3 FROM table_name;

-- VARIATIONS WITH DIFFERENT COLUMN COUNTS:
-- SELECT id FROM table;  (1 column)
-- SELECT id, name FROM table;  (2 columns)
-- SELECT id, name, email FROM table;  (3 columns)
-- SELECT id, name, email, phone, address FROM table;  (5 columns)

-- ADVANTAGES:
-- 1. PERFORMANCE: Only retrieves needed columns
-- 2. BANDWIDTH: Smaller data transfer
-- 3. MEMORY: Uses less memory
-- 4. CLARITY: Intent is clear
-- 5. MAINTENANCE: Code doesn't break if table structure changes
-- 6. OPTIMIZATION: Can use index-only scans

-- EXAMPLE SCENARIO:
-- Need: customer names and emails only
-- Good: SELECT first_name, last_name, email FROM customer_table;
-- Bad: SELECT * FROM customer_table; (includes age, ID, other columns)

-- PERFORMANCE COMPARISON:
-- Table: 10 columns, 1 million rows
-- SELECT *: Transfers ~500MB of data
-- SELECT col1, col2, col3: Transfers ~150MB of data (3x faster)


-- ============================================================
-- 4. SELECT WITH ALIASES (RENAMING COLUMNS)
-- ============================================================
SELECT first_name AS "Customer First Name", 
       last_name AS "Customer Last Name" 
FROM customer_table;

-- EXPLANATION:
-- - AS keyword creates alias for column
-- - AS "Customer First Name": Renames first_name in output
-- - Useful for: Clarity, readability, user-friendly names
-- - Original column name unchanged in table
-- - Only affects display/output

-- EXAMPLE OUTPUT:
-- | Customer First Name | Customer Last Name |
-- |--------------------|-------------------|
-- | John               | Smith             |
-- | Sarah              | Johnson           |
-- | Michael            | Brown             |

-- SYNTAX VARIATIONS:
-- AS keyword:
-- SELECT first_name AS fname FROM customer_table;
-- Without AS (also valid):
-- SELECT first_name fname FROM customer_table;
-- With quotes (for spaces in alias):
-- SELECT first_name AS "First Name" FROM customer_table;

-- WHEN TO USE ALIASES:
-- - Column names unclear or cryptic
-- - Display to non-technical users
-- - Calculations: SELECT salary * 12 AS "Annual Salary"
-- - Functions: SELECT COUNT(*) AS "Total Customers"
-- - JOIN queries (avoid column confusion)
-- - Reports and dashboards

-- BEST PRACTICES:
-- - Use meaningful aliases
-- - Use quotes for multi-word aliases
-- - Keep aliases concise
-- - Be consistent


-- ============================================================
-- 5. SELECT WITH WHERE CLAUSE (FILTERING)
-- ============================================================
SELECT first_name, last_name, age 
FROM customer_table 
WHERE age > 30;

-- EXPLANATION:
-- - SELECT columns: Which columns to retrieve
-- - FROM table: Source table
-- - WHERE age > 30: Filter condition
-- - Returns: Only rows matching the condition
-- - Excludes: Rows where age <= 30

-- EXAMPLE OUTPUT (filtered):
-- | first_name | last_name | age |
-- |-----------|-----------|-----|
-- | Michael   | Brown     | 35  |
-- | David     | Lee       | 45  |
-- | Sarah     | Johnson   | 31  |
-- (Only customers over 30)

-- EXAMPLE OUTPUT (without WHERE):
-- | first_name | last_name | age |
-- |-----------|-----------|-----|
-- | John      | Smith     | 25  | ← filtered out (age <= 30)
-- | Sarah     | Johnson   | 31  | ← included
-- | Michael   | Brown     | 35  | ← included
-- | David     | Lee       | 45  | ← included
-- | Emma      | Wilson    | 28  | ← filtered out (age <= 30)

-- COMMON WHERE CONDITIONS:
-- WHERE age = 25  (equals)
-- WHERE age > 30  (greater than)
-- WHERE age >= 30 (greater than or equal)
-- WHERE age < 30  (less than)
-- WHERE age <= 30 (less than or equal)
-- WHERE age <> 25 (not equal)
-- WHERE age BETWEEN 25 AND 35 (range)
-- WHERE name LIKE 'J%' (pattern match)
-- WHERE status IN ('Active', 'Pending') (multiple values)


-- ============================================================
-- 6. SELECT WITH ORDER BY (SORTING)
-- ============================================================
SELECT first_name, last_name, age 
FROM customer_table 
ORDER BY age DESC;

-- EXPLANATION:
-- - ORDER BY age: Sort by age column
-- - DESC: Descending order (high to low)
-- - ASC: Ascending order (low to high) - default if not specified
-- - Organizes results in specified order

-- ASCENDING (default):
-- SELECT first_name FROM customer_table ORDER BY first_name;
-- Output: Adam, Alex, Alice, Andrew, ... (A to Z)

-- DESCENDING:
-- SELECT first_name FROM customer_table ORDER BY first_name DESC;
-- Output: Zoe, Zachary, ... David, ... Alice, Adam (Z to A)

-- EXAMPLE OUTPUT (sorted by age DESC):
-- | first_name | last_name | age |
-- |-----------|-----------|-----|
-- | David     | Lee       | 45  | (oldest first)
-- | Michael   | Brown     | 35  |
-- | Sarah     | Johnson   | 31  |
-- | John      | Smith     | 25  |
-- | Emma      | Wilson    | 28  |

-- MULTIPLE COLUMN SORTING:
-- SELECT * FROM customer_table ORDER BY last_name ASC, first_name ASC;
-- Sorts by last_name first, then first_name within same last_name

-- WHEN TO USE ORDER BY:
-- - Reports and dashboards
-- - List data in meaningful order
-- - Top/bottom analysis
-- - User-friendly results
-- - Chronological data


-- ============================================================
-- 7. SELECT WITH LIMIT (RESTRICT ROWS)
-- ============================================================
SELECT first_name, last_name 
FROM customer_table 
LIMIT 10;

-- EXPLANATION:
-- - LIMIT 10: Return only first 10 rows
-- - Useful for: Preview data, pagination, performance
-- - Combined with ORDER BY for top/bottom results

-- EXAMPLE OUTPUT:
-- | first_name | last_name |
-- |-----------|-----------|
-- | John      | Smith     | (1)
-- | Sarah     | Johnson   | (2)
-- | Michael   | Brown     | (3)
-- | David     | Lee       | (4)
-- | Emma      | Wilson    | (5)
-- | Alex      | Martinez  | (6)
-- | Lisa      | Garcia    | (7)
-- | Chris     | Rodriguez | (8)
-- | John      | Moore     | (9)
-- | Sarah     | Taylor    | (10)

-- LIMIT WITH OFFSET:
-- SELECT * FROM customer_table LIMIT 10 OFFSET 20;
-- Skips first 20 rows, returns next 10 rows (rows 21-30)
-- Useful for pagination: Page 1: OFFSET 0, Page 2: OFFSET 10, etc.

-- WHEN TO USE:
-- - Explore large tables (avoid loading everything)
-- - Pagination for websites/apps
-- - Top N results: Top 5 highest salaries
-- - Performance: Reduce data transfer


-- ============================================================
-- 8. SELECT WITH AGGREGATE FUNCTIONS
-- ============================================================
SELECT COUNT(*) AS "Total Customers" 
FROM customer_table;

-- EXPLANATION:
-- - COUNT(*): Count all rows
-- - AS: Alias for result column
-- - Result: Single number (row count)

-- COMMON AGGREGATE FUNCTIONS:
-- COUNT(*): Count all rows
-- COUNT(column): Count non-NULL values in column
-- SUM(column): Add up all values
-- AVG(column): Calculate average
-- MIN(column): Find minimum value
-- MAX(column): Find maximum value

-- EXAMPLES:
-- SELECT COUNT(*) FROM orders; (Total orders)
-- SELECT SUM(salary) FROM employees; (Total salary cost)
-- SELECT AVG(age) FROM customers; (Average customer age)
-- SELECT MIN(price) FROM products; (Cheapest product)
-- SELECT MAX(salary) FROM employees; (Highest salary)

-- EXAMPLE OUTPUT:
-- | Total Customers |
-- |----------------|
-- | 1542           |


-- ============================================================
-- 9. COMPLETE EXAMPLE - COMBINE MULTIPLE CONCEPTS
-- ============================================================
SELECT first_name AS "First Name", 
       last_name AS "Last Name", 
       age AS "Age"
FROM customer_table
WHERE age >= 25 AND age <= 50
ORDER BY age DESC
LIMIT 5;

-- EXPLANATION:
-- - SELECT: Columns to retrieve with aliases
-- - FROM: Source table
-- - WHERE: Filter to age 25-50
-- - ORDER BY: Sort by age descending (oldest first)
-- - LIMIT 5: Return only top 5 rows

-- EXAMPLE OUTPUT:
-- | First Name | Last Name | Age |
-- |-----------|-----------|-----|
-- | David     | Lee       | 45  |
-- | Michael   | Brown     | 38  |
-- | Sarah     | Johnson   | 35  |
-- | Lisa      | Martinez  | 28  |
-- | John      | Smith     | 25  |


-- ============================================================
-- BEST PRACTICES FOR SELECT
-- ============================================================

-- 1. SPECIFY COLUMNS (DON'T USE SELECT *)
-- Good:
-- SELECT id, name, email FROM users;
-- Bad:
-- SELECT * FROM users;
-- Reason: Performance, clarity, maintenance

-- 2. USE WHERE TO FILTER EARLY
-- Good:
-- SELECT name FROM users WHERE status = 'Active';
-- Bad:
-- SELECT * FROM users; (then filter in application)
-- Reason: Database does filtering efficiently

-- 3. USE ALIASES FOR CLARITY
-- Good:
-- SELECT salary * 12 AS "Annual Salary" FROM employees;
-- Bad:
-- SELECT salary * 12 FROM employees;
-- Reason: Clear meaning in results

-- 4. USE LIMIT FOR LARGE TABLES
-- Good:
-- SELECT * FROM large_table LIMIT 10; (preview)
-- Bad:
-- SELECT * FROM large_table; (load everything)
-- Reason: Performance, avoid memory issues

-- 5. USE ORDER BY FOR SORTED RESULTS
-- Good:
-- SELECT * FROM orders ORDER BY created_date DESC;
-- Bad:
-- SELECT * FROM orders; (unsorted)
-- Reason: Results organized meaningfully

-- 6. CREATE INDEXES ON FREQUENTLY QUERIED COLUMNS
-- CREATE INDEX idx_status ON users(status);
-- Reason: Speeds up WHERE and ORDER BY

-- 7. COMMENT YOUR QUERIES
-- -- Get all active customers over 30 years old
-- SELECT name, email FROM customers
-- WHERE status = 'Active' AND age > 30;
-- Reason: Documents purpose

-- 8. TEST WITH SMALL RESULT FIRST
-- SELECT * FROM large_table LIMIT 10;
-- -- Verify correct data before running full query
-- SELECT * FROM large_table;
-- Reason: Avoid long-running queries with errors

-- 9. USE MEANINGFUL COLUMN ALIASES
-- Good:
-- SELECT salary * 12 AS "Annual Salary"
-- Bad:
-- SELECT salary * 12 AS "sal_12"
-- Reason: Self-documenting, easier to understand

-- 10. AVOID CALCULATIONS ON FILTERED COLUMNS
-- Good:
-- SELECT * FROM orders WHERE total > 1000;
-- Bad:
-- SELECT * FROM orders WHERE total * 1.1 > 1000;
-- Reason: Can't use indexes, slower


-- ============================================================
-- SELECT PERFORMANCE TIPS
-- ============================================================

-- 1. Use LIMIT for large result sets
-- SELECT * FROM huge_table LIMIT 1000;
-- vs SELECT * FROM huge_table; (could be millions)

-- 2. Index WHERE columns
-- CREATE INDEX idx_email ON users(email);
-- Then: SELECT * FROM users WHERE email = 'test@email.com'; (fast)

-- 3. Use BETWEEN instead of multiple conditions
-- Good: WHERE age BETWEEN 25 AND 50
-- Slower: WHERE age >= 25 AND age <= 50

-- 4. Use IN for multiple values
-- Good: WHERE status IN ('Active', 'Pending')
-- Slower: WHERE status = 'Active' OR status = 'Pending'

-- 5. Avoid functions on WHERE columns
-- Good: WHERE created_date >= '2026-01-01'
-- Slower: WHERE YEAR(created_date) = 2026

-- 6. Use UNION instead of OR for disjoint queries
-- UNION combines results from multiple SELECT statements
-- Can be faster than single SELECT with many ORs

-- 7. Avoid SELECT * for large tables
-- SELECT id, name FROM users; (fast)
-- vs SELECT * FROM users; (slow, transfers all columns)

-- 8. Use appropriate data types
-- INT for ages vs VARCHAR for ages
-- Better indexing and faster comparisons


-- ============================================================
-- COMMON SELECT PATTERNS
-- ============================================================

-- Get all data:
-- SELECT * FROM customers;

-- Get specific columns:
-- SELECT id, name, email FROM customers;

-- Get filtered results:
-- SELECT * FROM customers WHERE status = 'Active';

-- Get top N results:
-- SELECT * FROM sales ORDER BY amount DESC LIMIT 10;

-- Get distinct values:
-- SELECT DISTINCT city FROM customers;

-- Count rows:
-- SELECT COUNT(*) FROM orders;

-- Get summary statistics:
-- SELECT AVG(salary), MIN(salary), MAX(salary) FROM employees;

-- Group and count:
-- SELECT department, COUNT(*) FROM employees GROUP BY department;

-- Pagination:
-- SELECT * FROM products LIMIT 10 OFFSET 20;

-- Search:
-- SELECT * FROM users WHERE name LIKE '%John%';
 