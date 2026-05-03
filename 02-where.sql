-- ============================================================
-- WHERE CLAUSE - FILTER ROWS BASED ON CONDITIONS
-- ============================================================
-- LEARNING GUIDE: Start with LESSON 01 and progress in order
-- WHERE filters data to return only rows matching specified conditions
-- Essential for reducing result set to relevant data
-- Used in SELECT, UPDATE, DELETE statements
-- Syntax: SELECT/UPDATE/DELETE FROM table WHERE condition;


-- ============================================================
-- LESSON 01: WHERE WITH EQUALITY OPERATOR (=)
-- ============================================================
SELECT first_name 
FROM customer_table 
WHERE age = 25;

-- EXPLANATION:
-- - SELECT first_name: Retrieve first name column
-- - FROM customer_table: From this table
-- - WHERE age = 25: Filter for rows where age equals 25
-- - = operator: Exact match (equals)
-- - Returns: Only rows with age = 25

-- TABLE DATA:
-- | first_name | age |
-- |-----------|-----|
-- | John      | 23  | ← NOT included (age ≠ 25)
-- | Sarah     | 25  | ← INCLUDED ✓
-- | Michael   | 28  | ← NOT included
-- | David     | 25  | ← INCLUDED ✓
-- | Emma      | 30  | ← NOT included

-- RESULT:
-- | first_name |
-- |-----------|
-- | Sarah     |
-- | David     |

-- WHEN TO USE:
-- - Exact match search
-- - Find specific value
-- - Filter by ID, category, status
-- - WHERE customer_id = 1
-- - WHERE status = 'Active'

-- IMPORTANT NOTE:
-- - = finds exact match
-- - For text: 'Gee' ≠ 'gee' (case sensitivity depends on database)
-- - For numbers: 25 = 25 (exact)


-- ============================================================
-- 2. WHERE WITH COMPARISON OPERATORS (>, <, >=, <=)
-- ============================================================
SELECT first_name, age 
FROM customer_table 
WHERE age > 25;

-- EXPLANATION:
-- - WHERE age > 25: Greater than operator
-- - > means strictly greater than (excludes 25)
-- - Returns: Rows where age is 26, 27, 28, etc.
-- - Does NOT include age = 25

-- TABLE DATA WITH FILTERING:
-- | first_name | age | age > 25 |
-- |-----------|-----|----------|
-- | John      | 23  | False ✗  | ← excluded
-- | Sarah     | 25  | False ✗  | ← excluded (equal to 25)
-- | Michael   | 28  | True ✓   | ← included
-- | David     | 25  | False ✗  | ← excluded
-- | Emma      | 30  | True ✓   | ← included

-- RESULT:
-- | first_name | age |
-- |-----------|-----|
-- | Michael   | 28  |
-- | Emma      | 30  |

-- COMPARISON OPERATORS:
-- > = Greater than (excludes boundary)
-- >= = Greater than or equal (includes boundary)
-- < = Less than (excludes boundary)
-- <= = Less than or equal (includes boundary)
-- = = Equal to (exact match)
-- <> or != = Not equal to (anything except value)

-- EXAMPLES WITH DIFFERENT OPERATORS:
-- WHERE age >= 25: Includes 25 and above
-- WHERE age < 25: Less than 25 (excludes 25)
-- WHERE age <= 25: 25 and below
-- WHERE age <> 25: Everything except 25

-- BOUNDARY COMPARISON:
-- WHERE age > 25: 26, 27, 28, ... (not 25)
-- WHERE age >= 25: 25, 26, 27, 28, ... (includes 25)
-- WHERE age < 25: 24, 23, 22, ... (not 25)
-- WHERE age <= 25: 25, 24, 23, ... (includes 25)


-- ============================================================
-- 3. WHERE WITH STRING MATCHING (TEXT)
-- ============================================================
SELECT * 
FROM customer_table 
WHERE first_name = 'Gee';

-- EXPLANATION:
-- - WHERE first_name = 'Gee': Match exact text 'Gee'
-- - Text values MUST be in single quotes: 'Gee'
-- - Case sensitivity: Depends on database settings
-- - Returns: All columns for rows where first_name is 'Gee'

-- TABLE DATA:
-- | customer_id | first_name | last_name | age | email        |
-- |------------|-----------|-----------|-----|--------------|
-- | 1          | John      | Smith     | 25  | john@email.. |
-- | 2          | Gee       | Johnson   | 30  | gee@email.com| ← matches 'Gee'
-- | 3          | gee       | Brown     | 28  | gee2@email.. | ← may/may not match depending on case sensitivity
-- | 4          | Sarah     | Lee       | 32  | sarah@email..| 

-- RESULT:
-- | customer_id | first_name | last_name | age | email        |
-- |------------|-----------|-----------|-----|--------------|
-- | 2          | Gee       | Johnson   | 30  | gee@email.com|

-- CASE SENSITIVITY:
-- SQL Server: By default case-insensitive
--   'Gee' = 'gee' = 'GEE' (all match)
-- PostgreSQL: By default case-sensitive
--   'Gee' ≠ 'gee' ≠ 'GEE' (only 'Gee' matches)
-- MySQL: Depends on collation (usually case-insensitive)

-- WHEN TO USE:
-- - Search by name
-- - Filter by category
-- - Search by status string
-- - Find specific text value

-- IMPORTANT:
-- - Always use single quotes for text: 'Gee'
-- - Double quotes used for identifiers in some databases
-- - Empty string: WHERE name = ''
-- - NULL value: WHERE name IS NULL (not = NULL)


-- ============================================================
-- 4. WHERE WITH MULTIPLE CONDITIONS (AND)
-- ============================================================
SELECT * 
FROM customer_table 
WHERE age > 25 AND first_name = 'John';

-- EXPLANATION:
-- - WHERE age > 25 AND first_name = 'John'
-- - AND: Both conditions must be TRUE
-- - Condition 1: age > 25
-- - Condition 2: first_name = 'John'
-- - Returns: Rows where age > 25 AND name is John

-- LOGIC TABLE:
-- age > 25 | name = 'John' | Result (AND)
-- True     | True          | TRUE ✓ (included)
-- True     | False         | FALSE (excluded)
-- False    | True          | FALSE (excluded)
-- False    | False         | FALSE (excluded)

-- TABLE DATA:
-- | first_name | age | age>25 | name='John' | Both TRUE? |
-- |-----------|-----|--------|-------------|-----------|
-- | John      | 23  | False  | True       | False ✗   |
-- | Sarah     | 30  | True   | False      | False ✗   |
-- | John      | 28  | True   | True       | TRUE ✓    |
-- | Michael   | 35  | True   | False      | False ✗   |

-- RESULT: Only John (age 28) matches both conditions

-- WHEN TO USE AND:
-- - Multiple criteria all must be met
-- - Age range: WHERE age > 20 AND age < 30
-- - Status combinations: WHERE status = 'Active' AND region = 'North'
-- - Date range: WHERE date >= '2020-01-01' AND date < '2021-01-01'


-- ============================================================
-- 5. WHERE WITH MULTIPLE CONDITIONS (OR)
-- ============================================================
SELECT * 
FROM customer_table 
WHERE first_name = 'John' OR first_name = 'Sarah';

-- EXPLANATION:
-- - OR: At least ONE condition must be TRUE
-- - Condition 1: first_name = 'John'
-- - Condition 2: first_name = 'Sarah'
-- - Returns: Rows with either John or Sarah

-- LOGIC TABLE:
-- name = 'John' | name = 'Sarah' | Result (OR)
-- True          | True           | TRUE ✓
-- True          | False          | TRUE ✓
-- False         | True           | TRUE ✓
-- False         | False          | FALSE

-- TABLE DATA:
-- | first_name | name='John'|name='Sarah'| Either? |
-- |-----------|-----------|-----------|---------|
-- | John      | True      | False     | TRUE ✓  |
-- | Sarah     | False     | True      | TRUE ✓  |
-- | Michael   | False     | False     | FALSE ✗ |

-- CLEANER SYNTAX (same meaning):
-- WHERE first_name IN ('John', 'Sarah');

-- WHEN TO USE OR:
-- - Match any of multiple values
-- - Alternative conditions: age < 18 OR age > 65
-- - Status options: status = 'Active' OR status = 'Pending'
-- - Multiple names: Use IN instead


-- ============================================================
-- 6. WHERE WITH LIKE (PATTERN MATCHING)
-- ============================================================
SELECT * 
FROM customer_table 
WHERE first_name LIKE 'J%';

-- EXPLANATION:
-- - LIKE: Pattern matching for text
-- - 'J%': Starts with J, followed by any characters
-- - % wildcard: Matches any number of characters
-- - _ wildcard: Matches exactly one character
-- - Returns: Names starting with 'J' (John, James, Jessica, etc.)

-- PATTERN EXAMPLES:
-- LIKE 'J%': Starts with J (John, James, Jessica)
-- LIKE '%n': Ends with n (John, Susan, pattern)
-- LIKE '%oh%': Contains 'oh' anywhere (John, Johanna)
-- LIKE 'J_hn': Exactly 4 chars: J-?-h-n (John, Juan)

-- TABLE DATA:
-- | first_name | LIKE 'J%'? |
-- |-----------|-----------|
-- | John      | True ✓    |
-- | James     | True ✓    |
-- | Jessica   | True ✓    |
-- | Sarah     | False ✗   |
-- | Michael   | False ✗   |

-- WHEN TO USE:
-- - Search by partial name: WHERE name LIKE '%Smith%'
-- - Email domain: WHERE email LIKE '%@gmail.com'
-- - Phone pattern: WHERE phone LIKE '555-%'
-- - Partial matches: WHERE product LIKE 'Samsung%'


-- ============================================================
-- 7. WHERE WITH BETWEEN (RANGE)
-- ============================================================
SELECT * 
FROM customer_table 
WHERE age BETWEEN 25 AND 35;

-- EXPLANATION:
-- - BETWEEN: Inclusive range (includes both boundaries)
-- - Equivalent to: age >= 25 AND age <= 35
-- - Includes both 25 AND 35
-- - Cleaner syntax than AND conditions

-- TABLE DATA:
-- | first_name | age | BETWEEN 25 AND 35? |
-- |-----------|-----|-------------------|
-- | John      | 23  | False ✗          |
-- | Sarah     | 25  | True ✓           |
-- | Michael   | 30  | True ✓           |
-- | Emma      | 35  | True ✓           |
-- | David     | 40  | False ✗          |

-- WHEN TO USE:
-- - Age ranges: BETWEEN 18 AND 65
-- - Salary ranges: BETWEEN 40000 AND 80000
-- - Date ranges: BETWEEN '2020-01-01' AND '2020-12-31'
-- - Price ranges: BETWEEN 100 AND 500

-- BOUNDARY BEHAVIOR:
-- BETWEEN includes both boundaries (>= and <=)
-- BETWEEN 25 AND 35 includes: 25, 26, ..., 34, 35


-- ============================================================
-- 8. WHERE WITH IN (MULTIPLE VALUES)
-- ============================================================
SELECT * 
FROM customer_table 
WHERE first_name IN ('John', 'Sarah', 'Michael');

-- EXPLANATION:
-- - IN: Match any value in list
-- - Equivalent to: name = 'John' OR name = 'Sarah' OR name = 'Michael'
-- - Cleaner than multiple OR conditions
-- - Values in parentheses separated by commas

-- TABLE DATA:
-- | first_name | IN list? |
-- |-----------|----------|
-- | John      | True ✓   |
-- | Sarah     | True ✓   |
-- | Michael   | True ✓   |
-- | David     | False ✗  |
-- | Emma      | False ✗  |

-- WHEN TO USE:
-- - Multiple specific values: IN (1, 2, 3, 4)
-- - Status options: IN ('Active', 'Pending', 'OnHold')
-- - Categories: IN ('Electronics', 'Books', 'Clothing')
-- - Multiple IDs: IN (101, 102, 103)

-- NOT IN (opposite):
-- WHERE status NOT IN ('Deleted', 'Archived')
-- Excludes those values


-- ============================================================
-- 9. WHERE WITH NULL CHECK
-- ============================================================
SELECT * 
FROM customer_table 
WHERE email IS NULL;

-- EXPLANATION:
-- - IS NULL: Checks for NULL (empty/missing) values
-- - NULL is special: Can't use = NULL
-- - IS NULL finds missing values
-- - IS NOT NULL finds non-empty values

-- CORRECT vs INCORRECT:
-- Correct: WHERE email IS NULL
-- Incorrect: WHERE email = NULL (doesn't work!)

-- TABLE DATA:
-- | customer_id | email           | IS NULL? |
-- |------------|-----------------|----------|
-- | 1          | john@email.com  | False    |
-- | 2          | (NULL)          | True ✓   |
-- | 3          | sarah@email.com | False    |
-- | 4          | (NULL)          | True ✓   |

-- WHEN TO USE:
-- - Find incomplete records: WHERE phone IS NULL
-- - Data validation: WHERE required_field IS NULL
-- - Find empty fields: WHERE notes IS NULL
-- - Exclude blanks: WHERE description IS NOT NULL


-- ============================================================
-- 10. WHERE WITH NOT OPERATOR
-- ============================================================
SELECT * 
FROM customer_table 
WHERE NOT age = 25;

-- EXPLANATION:
-- - NOT: Negates condition
-- - NOT age = 25: Excludes age 25 (same as age <> 25)
-- - Reverses the condition

-- EQUIVALENT STATEMENTS:
-- WHERE NOT age = 25
-- WHERE age <> 25
-- WHERE age != 25
-- All three give same result

-- WHEN TO USE NOT:
-- - Exclude specific values: WHERE NOT status = 'Deleted'
-- - Opposite condition: WHERE NOT price > 100 (same as price <= 100)
-- - NOT LIKE: WHERE NOT name LIKE '%test%'
-- - NOT IN: WHERE NOT category IN ('Archive', 'Trash')


-- ============================================================
-- 11. COMPLEX WHERE WITH PARENTHESES
-- ============================================================
SELECT * 
FROM customer_table 
WHERE (age > 25 AND region = 'North') OR (age < 20 AND region = 'South');

-- EXPLANATION:
-- - Parentheses define evaluation order
-- - Part 1: (age > 25 AND region = 'North')
-- - Part 2: (age < 20 AND region = 'South')
-- - OR: Matches either part

-- WHEN TO USE:
-- - Complex conditions
-- - Clarify evaluation order
-- - Group related conditions
-- - Avoid ambiguity

-- OPERATOR PRECEDENCE (without parentheses):
-- 1. NOT (highest)
-- 2. AND
-- 3. OR (lowest)
-- BEST PRACTICE: Use parentheses to be explicit


-- ============================================================
-- WHERE CLAUSE COMPLETE EXAMPLES
-- ============================================================

-- Example 1: Single value
-- SELECT * FROM customers WHERE status = 'Active';

-- Example 2: Comparison
-- SELECT * FROM products WHERE price > 100;

-- Example 3: Multiple conditions
-- SELECT * FROM orders WHERE status = 'Pending' AND amount > 500;

-- Example 4: Pattern search
-- SELECT * FROM users WHERE email LIKE '%@gmail.com';

-- Example 5: Range
-- SELECT * FROM sales WHERE amount BETWEEN 1000 AND 5000;

-- Example 6: Multiple values
-- SELECT * FROM employees WHERE department IN ('IT', 'HR', 'Sales');

-- Example 7: NULL check
-- SELECT * FROM contacts WHERE phone IS NOT NULL;

-- Example 8: Complex condition
-- SELECT * FROM orders WHERE 
-- (customer_type = 'VIP' AND purchase_amount > 10000) 
-- OR 
-- (customer_type = 'Regular' AND purchase_amount > 5000);


-- ============================================================
-- BEST PRACTICES FOR WHERE CLAUSE
-- ============================================================

-- 1. USE WHERE TO FILTER EARLY
-- Good:
-- SELECT first_name FROM customers WHERE age > 25;
-- Bad:
-- SELECT first_name FROM customers; (filter in application)
-- Reason: Database does filtering efficiently

-- 2. USE SPECIFIC CONDITIONS
-- Good:
-- WHERE customer_id = 1
-- Bad:
-- WHERE customer_id IS NOT NULL AND age > 0
-- Reason: More efficient, clearer intent

-- 3. USE IN FOR MULTIPLE VALUES (NOT OR)
-- Good:
-- WHERE status IN ('Active', 'Pending')
-- Bad:
-- WHERE status = 'Active' OR status = 'Pending'
-- Reason: Cleaner, easier to read

-- 4. USE BETWEEN FOR RANGES
-- Good:
-- WHERE age BETWEEN 25 AND 50
-- Bad:
-- WHERE age >= 25 AND age <= 50
-- Reason: Shorter, clearer intent

-- 5. INDEX WHERE COLUMNS
-- CREATE INDEX idx_status ON orders(status);
-- Then: SELECT * FROM orders WHERE status = 'Pending'; (faster)
-- Reason: Indexed queries execute faster

-- 6. USE LIKE CORRECTLY
-- Good:
-- WHERE email LIKE '%@gmail.com'
-- Bad:
-- WHERE email LIKE '%gmail%'
-- Reason: More specific, faster

-- 7. HANDLE NULL PROPERLY
-- Good:
-- WHERE email IS NULL
-- Bad:
-- WHERE email = NULL (doesn't work!)
-- Reason: NULL requires IS NULL check

-- 8. USE PARENTHESES FOR CLARITY
-- Good:
-- WHERE (status = 'Active' AND age > 25) OR (status = 'VIP')
-- Bad:
-- WHERE status = 'Active' AND age > 25 OR status = 'VIP'
-- Reason: Clear intent, avoids ambiguity

-- 9. TEST CONDITIONS SEPARATELY
-- Test: SELECT * FROM table WHERE condition1;
-- Test: SELECT * FROM table WHERE condition2;
-- Test: SELECT * FROM table WHERE condition1 AND condition2;
-- Reason: Verify each condition works

-- 10. DOCUMENT COMPLEX CONDITIONS
-- -- Find high-value customers in target regions
-- SELECT * FROM customers 
-- WHERE purchase_amount > 50000 AND region IN ('North', 'East')
-- Reason: Explains business logic


-- ============================================================
-- WHERE PERFORMANCE TIPS
-- ============================================================

-- 1. INDEX WHERE COLUMNS
-- Most frequently filtered columns should be indexed
-- CREATE INDEX idx_age ON customer_table(age);

-- 2. FILTER ON INDEXED COLUMNS FIRST
-- Indexed columns filter faster

-- 3. AVOID FUNCTIONS IN WHERE
-- Good: WHERE created_date >= '2026-01-01'
-- Slow: WHERE YEAR(created_date) = 2026
-- (Can't use index with function)

-- 4. USE SPECIFIC OPERATORS
-- Good: WHERE age > 20 AND age < 30
-- Better: WHERE age BETWEEN 20 AND 30 (uses index better)

-- 5. ORDER BY WHERE SELECTIVITY
-- Put most selective condition first
-- WHERE status = 'Active' AND age > 40
-- (If few active users, filter those first)


-- ============================================================
-- COMMON WHERE CLAUSE MISTAKES
-- ============================================================

-- MISTAKE 1: Using = with NULL
-- Wrong: WHERE email = NULL
-- Right: WHERE email IS NULL
-- Fix: NULL requires IS NULL, not =

-- MISTAKE 2: Missing quotes on text
-- Wrong: WHERE first_name = John
-- Right: WHERE first_name = 'John'
-- Fix: Text values must be in single quotes

-- MISTAKE 3: Case sensitivity issues
-- May work on SQL Server but fail on PostgreSQL
-- Use UPPER() for case-insensitive: WHERE UPPER(name) = 'JOHN'

-- MISTAKE 4: Logic errors with AND/OR
-- Wrong: Find young OR senior customers
-- WHERE age < 20 AND age > 60 (impossible!)
-- Right: WHERE age < 20 OR age > 60

-- MISTAKE 5: Boundary errors with operators
-- Wrong: Get ages 25-30: WHERE age > 25 AND age < 30
-- (Excludes 25 and 30)
-- Right: WHERE age >= 25 AND age <= 30 (or BETWEEN 25 AND 30)


-- ============================================================
-- WHERE SYNTAX REFERENCE
-- ============================================================

-- Basic syntax:
-- SELECT columns FROM table WHERE condition;

-- Multiple columns:
-- SELECT col1, col2, col3 FROM table WHERE condition;

-- All columns:
-- SELECT * FROM table WHERE condition;

-- With ORDER BY:
-- SELECT * FROM table WHERE condition ORDER BY column;

-- With LIMIT:
-- SELECT * FROM table WHERE condition LIMIT 10;

-- UPDATE with WHERE:
-- UPDATE table SET column = value WHERE condition;

-- DELETE with WHERE:
-- DELETE FROM table WHERE condition;
