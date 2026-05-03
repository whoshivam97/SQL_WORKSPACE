-- ============================================================
-- IN OPERATOR - MATCH VALUES FROM A LIST
-- ============================================================
-- The IN operator checks whether a column value matches any value
-- in a specified list. It is a shorthand for multiple OR conditions.
-- Syntax: column_name IN (value1, value2, ...)

SELECT * 
FROM customer 
WHERE city IN ('Henderson', 'Los Angeles');

-- EXPLANATION:
-- - SELECT *: Returns all columns from matching rows
-- - FROM customer: Source table
-- - WHERE city IN (...): Filters rows where city is one of the listed values
-- - IN list: Contains two cities, so rows with either city are returned

-- WHEN TO USE:
-- - Filter by multiple discrete values
-- - Replace repeated OR clauses
-- - Search for specific categories or groups of values
-- - Keep queries concise and readable

-- EXAMPLE 2: SELECT A SPECIFIC COLUMN WHERE GRADE IS IN A LIST
SELECT Name
FROM Students
WHERE Grade IN ('A', 'B');

-- EXPLANATION:
-- - SELECT Name: Returns only the Name column
-- - FROM Students: Source table
-- - WHERE Grade IN (...): Filters rows where Grade is either A or B
-- - IN is useful when matching one column against multiple values

-- NOTE:
-- - Use commas to separate values inside IN
-- - Value types in the list should match the column type
-- - Parentheses are required around the list of values