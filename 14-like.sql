-- ============================================================
-- LIKE OPERATOR - PATTERN MATCHING FOR TEXT SEARCH
-- ============================================================
-- The LIKE operator performs pattern matching on text columns.
-- It is used to search for specified patterns within a string.
-- Syntax: column_name LIKE pattern
-- Wildcards: % (multiple characters), _ (single character)

-- EXAMPLE 1: MATCH STRINGS THAT START WITH 'A'
SELECT *
FROM customer
WHERE customer_name LIKE 'A%';

-- EXPLANATION:
-- - LIKE 'A%': Matches names starting with 'A'
-- - % wildcard: Represents zero or more characters
-- - Returns customers like: Andrew Allen, Alejandro Grove, Alan Dominguez, Alice McCarthy, etc.
-- - This dataset has many customers whose names start with 'A'

-- WILDCARDS:
-- - % = Zero or more characters (A%, %Z, %PATTERN%)
-- - _ = Exactly one character (A_B, _BC, etc.)

-- EXAMPLE 2: MATCH STRINGS THAT CONTAIN 'AND'
SELECT *
FROM customer
WHERE customer_name LIKE '%and%';

-- EXPLANATION:
-- - LIKE '%and%': Matches names containing 'and'
-- - Returns customers like: Alexander, Alejandro, Brandon, Hernandez, etc.
-- - % on both sides allows characters before and after the pattern

-- EXAMPLE 3: MATCH NAMES STARTING WITH 'AL'
SELECT *
FROM customer
WHERE customer_name LIKE 'Al%';

-- EXPLANATION:
-- - LIKE 'Al%': Matches names starting with 'Al'
-- - Returns: Alan Dominguez, Alan Hwang, Alan Haines, Alan Schoenberger, Alejandro Grove, etc.
-- - More specific than just 'A%'

-- EXAMPLE 4: MATCH NAMES WITH SINGLE CHARACTER WILDCARD
SELECT *
FROM customer
WHERE customer_name LIKE 'A_e%';

-- EXPLANATION:
-- - LIKE 'A_e%': Starts with 'A', followed by any single character, then 'e'
-- - _ wildcard: Represents exactly one character
-- - Matches: Alex Avila, Aimee Bixby, Anemone Ratner, etc.

-- WHEN TO USE:
-- - Search by partial text (names, addresses, emails)
-- - Pattern matching within a string
-- - Case-insensitive search (in most databases)
-- - Find variations of a word

-- PERFORMANCE NOTE:
-- - LIKE with leading % (e.g., '%pattern') cannot use indexes efficiently
-- - LIKE 'pattern%' is more efficient as it can use index
-- - Use other methods for complex pattern matching if performance is critical
