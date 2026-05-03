-- ============================================================
-- BETWEEN OPERATOR - MATCH VALUES IN A RANGE
-- ============================================================
-- The BETWEEN operator selects values within a given range.
-- It is inclusive of the boundary values.
-- Syntax: column_name BETWEEN lower_value AND upper_value

SELECT *
FROM customer
WHERE age BETWEEN 20 AND 30;

-- EXPLANATION:
-- - SELECT *: Returns all columns from rows matching the filter
-- - FROM customer: Source table
-- - WHERE age BETWEEN 20 AND 30: Filters rows where age is 20 through 30 inclusive
-- - BETWEEN is shorthand for age >= 20 AND age <= 30

-- WHEN TO USE:
-- - Filter rows on a continuous range of values
-- - Search by dates, ages, prices, or numeric ranges
-- - Replace two comparison conditions with a cleaner expression

-- NOTE:
-- - BETWEEN includes both lower and upper bounds
-- - For exclusive ranges, use > and < instead
-- - The order is important: lower bound first, upper bound second

-- EXAMPLE 2: NOT BETWEEN TO EXCLUDE A RANGE
SELECT *
FROM customer
WHERE age NOT BETWEEN 20 AND 30;

-- EXPLANATION:
-- - NOT BETWEEN excludes values inside the range
-- - Includes rows where age is less than 20 or greater than 30                                                                             1 1 1 1 1 1 `
-- - Equivalent to: age < 20 OR age > 30

-- EXAMPLE 3: BETWEEN WITH DATES
SELECT *
FROM sales
WHERE ship_date BETWEEN '2015-04-01' AND '2016-04-01';

-- EXPLANATION:
-- - Date range is inclusive of both start and end dates
-- - Useful for filtering events within a time window
-- - Ensure date format matches the database's expected literal format

