-- ============================================================
-- ORDER BY CLAUSE - SORTING RESULTS
-- ============================================================
-- The ORDER BY clause is used to sort the result set in ascending or descending order.
-- Syntax: SELECT columns FROM table ORDER BY column [ASC|DESC];
-- ASC = Ascending order (default, A-Z, 0-9)
-- DESC = Descending order (Z-A, 9-0)

-- ============================================================
-- EXAMPLE 1: ORDER BY SINGLE COLUMN (DEFAULT ASC)
-- ============================================================
SELECT *
FROM customer
WHERE state = 'California'
ORDER BY customer_name;

-- EXPLANATION:
-- - WHERE state = 'California': Filters only California customers
-- - ORDER BY customer_name: Sorts by customer name alphabetically (A to Z)
-- - ASC is default, so no need to explicitly mention it
-- - Results: Customers from California sorted by name in ascending order

-- ============================================================
-- EXAMPLE 2: ORDER BY SINGLE COLUMN DESCENDING
-- ============================================================
SELECT *
FROM customer
WHERE state = 'California'
ORDER BY customer_name DESC;

-- EXPLANATION:
-- - WHERE state = 'California': Filters only California customers
-- - ORDER BY customer_name DESC: Sorts names in descending order (Z to A)
-- - DESC keyword reverses the sort order
-- - Results: Same customers but names sorted from Z to A

-- ============================================================
-- EXAMPLE 3: ORDER BY MULTIPLE COLUMNS
-- ============================================================
SELECT *
FROM customer
ORDER BY city ASC, customer_name DESC;

-- EXPLANATION:
-- - ORDER BY city ASC: First, sorts by city in ascending order (A to Z)
-- - , customer_name DESC: Then, within each city, sorts by name descending (Z to A)
-- - Multiple columns create hierarchical sorting
-- - Results: Grouped by city alphabetically, then names in reverse alphabetical order

-- EXAMPLE:
-- | City        | Customer_Name |
-- | Austin      | Zoe           |
-- | Austin      | John          |
-- | Boston      | Mary          |
-- | Boston      | Alex          |

-- ============================================================
-- EXAMPLE 4: ORDER BY COLUMN POSITION NUMBER
-- ============================================================
SELECT *
FROM customer
ORDER BY 2 ASC;

-- EXPLANATION:
-- - ORDER BY 2: Sorts by the 2nd column in the SELECT statement
-- - Column position: 1 = first column, 2 = second column, etc.
-- - In this case, column 2 would be the second column from SELECT *
-- - ASC: Ascending order (default)

-- NOTE:
-- - Using column position is less readable than column names
-- - Recommended: Use column names instead (ORDER BY customer_name)
-- - Column positions can change if table structure changes

-- ============================================================
-- EXAMPLE 5: ORDER BY NUMERIC COLUMN DESCENDING
-- ============================================================
SELECT *
FROM customer
ORDER BY age DESC;

-- EXPLANATION:
-- - ORDER BY age DESC: Sorts customers by age in descending order (oldest first)
-- - DESC: Highest age values appear first
-- - Works with numeric columns (age, salary, quantity, etc.)
-- - Results: Customers listed from oldest to youngest

-- PERFORMANCE NOTE:
-- - Sorting large datasets can be slow
-- - Consider adding indexes on columns used in ORDER BY for better performance
-- - ORDER BY is typically one of the last operations in query execution
