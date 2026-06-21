-- ============================================================
-- AS CLAUSE - COLUMN AND TABLE ALIASES
-- ============================================================
-- The AS clause is used to give a temporary name (alias) to a column or table.
-- Aliases are used to make column/table names more readable or shorter.
-- Syntax: SELECT column_name AS alias_name FROM table_name;
-- Note: Aliases only exist during query execution, don't change actual table structure

-- ============================================================
-- EXAMPLE 1: ALIASING MULTIPLE COLUMNS
-- ============================================================
SELECT 
    customer_id AS "Serial number",
    customer_name AS name,
    Age AS cutomer_age
FROM Customer;

-- EXPLANATION:
-- - customer_id AS "Serial number": Renames customer_id column to "Serial number"
-- - customer_name AS name: Renames customer_name column to "name"
-- - Age AS cutomer_age: Renames Age column to "cutomer_age"
-- - Aliases appear in result set headers instead of original column names

-- OUTPUT HEADERS:
-- | Serial number | name | cutomer_age |
-- |---------------|------|-------------|

-- BENEFITS OF ALIASES:
-- - Improve readability of results
-- - Shorten long column names
-- - Create meaningful names for calculated columns
-- - Avoid ambiguity when joining tables with same column names

-- ============================================================
-- ALIAS SYNTAX VARIATIONS
-- ============================================================
-- - AS keyword: SELECT column_name AS alias_name
-- - Without AS: SELECT column_name alias_name (works in most databases)
-- - With quotes: SELECT column_name AS "Alias Name" (required if alias has spaces)
-- - Without quotes: SELECT column_name AS AliasName (no spaces needed)

-- ============================================================
-- COMMON USE CASES
-- ============================================================
-- 1. Calculated columns:
--    SELECT salary * 12 AS annual_salary FROM employees;
-- 2. Aggregation functions:
--    SELECT COUNT(*) AS total_customers FROM customers;
-- 3. Shortening long names:
--    SELECT product_description AS product FROM products;
-- 4. Table aliases (for JOINs):
--    SELECT c.name, o.order_id FROM customers AS c JOIN orders AS o;