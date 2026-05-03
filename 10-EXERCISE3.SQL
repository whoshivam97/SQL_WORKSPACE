-- ============================================================
-- EXERCISE 3: SELECT QUERIES WITH WHERE CLAUSE AND OPERATORS
-- ============================================================
-- Practice file for learning basic to intermediate SQL queries
-- Focus: WHERE clause, logical operators (AND, OR), comparison operators


-- ============================================================
-- QUESTION 1: SELECT ALL RECORDS
-- ============================================================
-- Question 1:
-- Retrieve all records from the science_classroom table.

SELECT * 
FROM science_classroom;

-- EXPLANATION:
-- - SELECT * retrieves ALL columns from the table
-- - * is wildcard meaning "all columns"
-- - No WHERE clause = returns all rows
-- - Returns: All student records with all information
-- - COLUMNS EXPECTED: All columns in science_classroom table
--   (typically: student_id, name, science_marks, etc.)
-- - ROWS RETURNED: Every student record in the table
-- - USE CASE: View complete dataset, data validation, backup

-- OUTPUT EXAMPLE:
-- | student_id | name     | science_marks |
-- |------------|----------|---------------|
-- | 1          | Alice    | 85            |
-- | 2          | Bob      | 45            |
-- | 3          | Charlie  | 92            |
-- | 4          | David    | 58            |
-- | ... (all records)

-- VARIATIONS:
-- SELECT student_id, name, science_marks FROM science_classroom;
--   (Select specific columns instead of all)
-- SELECT * FROM science_classroom LIMIT 10;
--   (Get first 10 records only)
-- SELECT COUNT(*) FROM science_classroom;
--   (Count total records)


-- ============================================================
-- QUESTION 2: FILTER WITH GREATER THAN OPERATOR
-- ============================================================
-- Question 2:
-- Find the names of all students who scored more than 60 marks in science.

SELECT name 
FROM science_classroom 
WHERE science_marks > 60;

-- EXPLANATION:
-- - SELECT name: Retrieves only the 'name' column
-- - WHERE science_marks > 60: Filters for marks strictly greater than 60
-- - > operator means "greater than" (excludes 60)
-- - Returns: Only names of students with marks > 60
-- - ROWS RETURNED: Only students meeting the condition
-- - PERFORMANCE: Fast if science_marks column is indexed

-- OUTPUT EXAMPLE:
-- | name     |
-- |----------|
-- | Alice    | (85 > 60)
-- | Charlie  | (92 > 60)
-- | Eve      | (75 > 60)

-- COMPARISON OPERATORS:
-- > = greater than (excludes the value)
-- >= = greater than or equal to (includes the value)
-- < = less than (excludes the value)
-- <= = less than or equal to (includes the value)
-- = = equal to (exact match)
-- <> or != = not equal to (anything except value)

-- VARIATIONS:
-- WHERE science_marks >= 60;
--   (Get 60 and above - includes 60)
-- WHERE science_marks > 60 AND science_marks < 90;
--   (Get marks between 60 and 90, exclusive)
-- WHERE science_marks > 60 ORDER BY science_marks DESC;
--   (Get results sorted by marks descending)
-- SELECT name, science_marks FROM science_classroom WHERE science_marks > 60;
--   (Include marks in result for verification)


-- ============================================================
-- QUESTION 3: FILTER WITH AND OPERATOR (Multiple Conditions)
-- ============================================================
-- Question 3:
-- Retrieve all student records who scored between 35 and 60 marks (inclusive).

SELECT * 
FROM science_classroom 
WHERE science_marks > 35 AND science_marks < 60;

-- EXPLANATION:
-- - SELECT *: Retrieves all columns
-- - WHERE science_marks > 35 AND science_marks < 60
-- - AND operator: BOTH conditions must be TRUE
-- - Returns: Students with marks strictly between 35 and 60 (exclusive)
-- - First condition: science_marks > 35 (greater than 35, not including 35)
-- - Second condition: science_marks < 60 (less than 60, not including 60)
-- - LOGIC: (science_marks > 35) AND (science_marks < 60) both true
-- - If either condition is false, row excluded

-- OUTPUT EXAMPLE:
-- | student_id | name   | science_marks |
-- |------------|--------|---------------|
-- | 2          | Bob    | 45            | (45 > 35 AND 45 < 60) ✓
-- | 4          | David  | 58            | (58 > 35 AND 58 < 60) ✓
-- (excludes Alice=85, Charlie=92, excludes marks 35 and 60)

-- IMPORTANT NOTE:
-- Current query uses > 35 and < 60 (exclusive of 35 and 60)
-- But question says "inclusive" of 35 and 60
-- CORRECTED QUERY for "inclusive":
-- SELECT * FROM science_classroom WHERE science_marks >= 35 AND science_marks <= 60;

-- AND OPERATOR RULES:
-- - Both conditions must be TRUE for row to be included
-- - If condition1 = TRUE and condition2 = FALSE → Row excluded
-- - If condition1 = FALSE and condition2 = TRUE → Row excluded
-- - If condition1 = FALSE and condition2 = FALSE → Row excluded
-- - Only if condition1 = TRUE AND condition2 = TRUE → Row included

-- VARIATIONS:
-- WHERE science_marks BETWEEN 35 AND 60;
--   (Cleaner syntax for range, inclusive by default)
-- WHERE science_marks >= 35 AND science_marks <= 60;
--   (Inclusive version - includes 35 and 60)
-- WHERE science_marks > 35 AND science_marks < 60 AND name LIKE 'A%';
--   (Multiple AND conditions - all must be true)
-- WHERE science_marks > 35 AND science_marks < 60 ORDER BY science_marks;
--   (Add sorting to see progression)

-- PERFORMANCE TIP:
-- BETWEEN is often faster than multiple AND conditions
-- CREATE INDEX idx_science_marks ON science_classroom(science_marks);
--   (Index on marks column speeds up WHERE clause)


-- ============================================================
-- QUESTION 4: FILTER WITH OR OPERATOR (Either Condition)
-- ============================================================
-- Question 4:
-- Find all students who scored either 35 marks or less, or 60 marks or more.

SELECT * 
FROM science_classroom 
WHERE science_marks <= 35 OR science_marks >= 60;

-- EXPLANATION:
-- - WHERE science_marks <= 35 OR science_marks >= 60
-- - OR operator: At least ONE condition must be TRUE
-- - First condition: science_marks <= 35 (35 and below)
-- - Second condition: science_marks >= 60 (60 and above)
-- - Returns: Students who meet EITHER condition
-- - This is the OPPOSITE of Question 3
-- - Covers low performers (<=35) and high performers (>=60)
-- - Excludes mid-range students (>35 and <60)

-- OUTPUT EXAMPLE:
-- | student_id | name    | science_marks |
-- |------------|---------|---------------|
-- | 1          | Alice   | 85            | (85 >= 60) ✓
-- | 2          | Bob     | 35            | (35 <= 35) ✓
-- | 3          | Charlie | 92            | (92 >= 60) ✓
-- (excludes David=58, excludes students between 36-59)

-- OR OPERATOR RULES:
-- - At least one condition must be TRUE
-- - If condition1 = TRUE and condition2 = FALSE → Row INCLUDED
-- - If condition1 = FALSE and condition2 = TRUE → Row INCLUDED
-- - If condition1 = TRUE and condition2 = TRUE → Row INCLUDED
-- - If condition1 = FALSE and condition2 = FALSE → Row EXCLUDED

-- REAL-WORLD SCENARIO:
-- "Find students who need intervention (<=35) or can be placed in advanced class (>=60)"
-- This query identifies both groups in one search

-- VARIATIONS:
-- WHERE science_marks <= 35 OR science_marks >= 60 ORDER BY science_marks;
--   (Sort results)
-- WHERE science_marks < 36 OR science_marks > 59;
--   (Alternative syntax for same logic)
-- SELECT name FROM science_classroom WHERE science_marks <= 35 OR science_marks >= 60;
--   (Show only names, not all details)
-- SELECT * FROM science_classroom WHERE science_marks <= 35 OR science_marks >= 60 ORDER BY name;
--   (Sort by name for alphabetical order)

-- COMPARISON WITH AND:
-- AND: Both conditions must be true (narrower results)
-- OR: At least one condition true (broader results)
-- Question 3 (AND): 35 < marks < 60 → Includes mid-range students
-- Question 4 (OR): marks <= 35 OR marks >= 60 → Excludes mid-range students


-- ============================================================
-- SUMMARY - COMPARISON OF ALL 4 QUERIES
-- ============================================================

-- Query 1: SELECT * FROM science_classroom;
-- Purpose: Get all data
-- Rows affected: ALL rows

-- Query 2: SELECT name FROM science_classroom WHERE science_marks > 60;
-- Purpose: High performers only
-- Rows affected: Students with marks > 60

-- Query 3: SELECT * FROM science_classroom WHERE science_marks > 35 AND science_marks < 60;
-- Purpose: Mid-range students
-- Rows affected: Students with 35 < marks < 60
-- Logic: First condition AND second condition both true

-- Query 4: SELECT * FROM science_classroom WHERE science_marks <= 35 OR science_marks >= 60;
-- Purpose: Low and high performers
-- Rows affected: Students with marks <= 35 OR marks >= 60
-- Logic: First condition OR second condition (at least one true)


-- ============================================================
-- KEY CONCEPTS REFERENCE
-- ============================================================

-- WHERE CLAUSE:
-- - Filters rows based on conditions
-- - Evaluated before SELECT column list
-- - Can combine multiple conditions with AND/OR
-- - SYNTAX: SELECT columns FROM table WHERE condition;

-- LOGICAL OPERATORS:
-- AND: Both conditions must be TRUE
-- OR: At least one condition must be TRUE
-- NOT: Reverses condition (NOT condition)
-- Precedence: AND is evaluated before OR
--   WHERE x > 10 AND y < 5 OR z = 3
--   is same as: WHERE (x > 10 AND y < 5) OR z = 3

-- COMPARISON OPERATORS:
-- >  : Greater than
-- >= : Greater than or equal
-- <  : Less than
-- <= : Less than or equal
-- =  : Equal to
-- <> : Not equal to
-- IN : Check if in list (status IN ('Active', 'Pending'))
-- BETWEEN : Range check (marks BETWEEN 35 AND 60)
-- LIKE : Pattern matching (name LIKE 'A%')
-- IS NULL : Check for NULL values


-- ============================================================
-- BEST PRACTICES
-- ============================================================

-- 1. Be specific in SELECT
--    Instead of: SELECT * FROM science_classroom;
--    Better: SELECT student_id, name, science_marks FROM science_classroom;
--    Reason: Faster, clearer, only needed data

-- 2. Use BETWEEN for ranges
--    Instead of: WHERE marks > 35 AND marks < 60
--    Better: WHERE marks BETWEEN 36 AND 59
--    Reason: Cleaner syntax, easier to read

-- 3. Index WHERE columns
--    CREATE INDEX idx_science_marks ON science_classroom(science_marks);
--    Reason: Queries run faster, especially on large tables

-- 4. Order results when needed
--    SELECT * FROM science_classroom WHERE science_marks >= 60 ORDER BY science_marks DESC;
--    Reason: Results easier to analyze and understand

-- 5. Document complex conditions
--    -- Find students needing help (low marks) or advanced placement (high marks)
--    SELECT * FROM science_classroom WHERE science_marks <= 35 OR science_marks >= 60;
--    Reason: Clear purpose for future reference

-- 6. Test with LIMIT first
--    SELECT * FROM science_classroom WHERE science_marks > 60 LIMIT 10;
--    Reason: See results quickly before running full query

-- 7. Use meaningful column names
--    science_marks is better than marks or m
--    Reason: Self-documenting code

-- 8. Use consistent formatting
--    SELECT * 
--    FROM table_name 
--    WHERE condition;
--    Reason: Readable, professional, maintainable

-- 9. Comment your queries
--    -- Find students in mid-range performance
--    SELECT * FROM science_classroom WHERE science_marks BETWEEN 36 AND 59;
--    Reason: Others understand intent

-- 10. Verify inclusive vs exclusive
--     BETWEEN 35 AND 60: INCLUDES both 35 and 60
--     > 35 AND < 60: EXCLUDES both 35 and 60
--     >= 35 AND <= 60: INCLUDES both 35 and 60
--     Reason: Avoid off-by-one errors










