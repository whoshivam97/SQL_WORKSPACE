-- ============================================================
-- EXERCISE 3: SQL PRACTICE QUERIES (DISTINCT, IN, BETWEEN, LIKE)
-- ============================================================
-- Database: Supermart_DB
-- Table: Superstore
-- Topics: IN, BETWEEN, LIKE operators with pattern matching

-- ============================================================
-- a) GET CITIES BY REGION USING IN OPERATOR
-- ============================================================
-- Query: Get the list of all cities where the region is North or East 
-- without any duplicates using IN statement.

SELECT DISTINCT City
FROM Superstore
WHERE Region IN ('North', 'East');

-- EXPLANATION:
-- - SELECT DISTINCT City: Fetches city names and removes duplicates
-- - FROM Superstore: From the Superstore table
-- - WHERE Region IN ('North', 'East'): Filters rows where region matches 'North' OR 'East'
-- - IN operator checks if value matches any in the list

-- EXAMPLE:
-- If table contains:
-- | City    | Region |
-- | Delhi   | North  |
-- | Kolkata | East   |
-- | Delhi   | North  |
-- Output: Delhi, Kolkata (Delhi appears once due to DISTINCT)

-- ============================================================
-- b) GET ORDERS USING BETWEEN OPERATOR
-- ============================================================
-- Query: Get the list of all orders where the Sales value is between 100 and 500 
-- using the BETWEEN operator.

SELECT *
FROM Superstore
WHERE Sales BETWEEN 100 AND 500;

-- EXPLANATION:
-- - SELECT *: Retrieves all columns
-- - FROM Superstore: From the Superstore table
-- - WHERE Sales BETWEEN 100 AND 500: Filters sales values from 100 to 500 (inclusive)
-- - BETWEEN includes both boundary values (100 and 500)

-- EQUIVALENT CONDITION:
-- WHERE Sales >= 100 AND Sales <= 500

-- EXAMPLE:
-- | Order_ID | Sales |
-- | 101      | 80    | (not selected)
-- | 102      | 250   | (selected)
-- | 103      | 500   | (selected)

-- ============================================================
-- c) GET CUSTOMERS USING LIKE PATTERN MATCHING
-- ============================================================
-- Query: Get the list of customers whose last name contains exactly 4 characters using LIKE.

SELECT *
FROM Superstore
WHERE Customer_Name LIKE '% ____';

-- EXPLANATION:
-- - SELECT *: Retrieves all columns
-- - LIKE '% ____': Pattern matching with wildcards
--   - % = Zero or more characters (any first name)
--   - Space = Literal space between first and last name
--   - ____ = Exactly 4 underscores (exactly 4 characters in last name)

-- WILDCARDS USED:
-- - % = Matches zero or more characters
-- - _ = Matches exactly one character

-- EXAMPLE:
-- | Customer_Name |
-- | John Paul     | (Paul = 4 chars, selected)
-- | Amit Kumar    | (Kumar = 5 chars, not selected)
-- | Ravi Raja     | (Raja = 4 chars, selected)

-- ============================================================
-- SQL CONCEPTS SUMMARY
-- ============================================================
-- DISTINCT: Removes duplicate records from result set
-- IN: Filters rows where column value matches any value in the list
-- BETWEEN: Filters values within a specified range (inclusive)
-- LIKE: Pattern matching for text searching
-- %: Wildcard for zero or more characters
-- _: Wildcard for exactly one character
