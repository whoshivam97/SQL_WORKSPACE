-- ============================================================
-- LOGICAL OPERATORS - AND, OR, NOT
-- ============================================================
-- Logical operators combine multiple conditions in WHERE clause
-- Used to filter rows based on complex criteria
-- Three main operators: AND, OR, NOT


-- ============================================================
-- 1. AND OPERATOR - ALL CONDITIONS MUST BE TRUE
-- ============================================================
SELECT first_name, last_name, age 
FROM customer_table 
WHERE age > 20 AND age < 30;

-- EXPLANATION:
-- - WHERE clause has two conditions connected by AND
-- - Condition 1: age > 20 (greater than 20)
-- - Condition 2: age < 30 (less than 30)
-- - AND operator: BOTH conditions must be TRUE for row inclusion
-- - Returns: Rows where age is between 21 and 29 (both conditions satisfied)

-- LOGIC TABLE FOR AND:
-- Condition1 | Condition2 | Result (AND)
-- True       | True       | TRUE ✓ (row included)
-- True       | False      | FALSE ✗ (row excluded)
-- False      | True       | FALSE ✗ (row excluded)
-- False      | False      | FALSE ✗ (row excluded)

-- EXAMPLE DATA:
-- | first_name | last_name | age |
-- |-----------|-----------|-----|
-- | John      | Smith     | 18  | (18 > 20: False) → Excluded
-- | Sarah     | Johnson   | 22  | (22 > 20: True AND 22 < 30: True) → INCLUDED ✓
-- | Michael   | Brown     | 28  | (28 > 20: True AND 28 < 30: True) → INCLUDED ✓
-- | David     | Lee       | 32  | (32 < 30: False) → Excluded
-- | Emma      | Wilson    | 25  | (25 > 20: True AND 25 < 30: True) → INCLUDED ✓

-- OUTPUT:
-- | first_name | last_name | age |
-- |-----------|-----------|-----|
-- | Sarah     | Johnson   | 22  |
-- | Michael   | Brown     | 28  |
-- | Emma      | Wilson    | 25  |

-- ALTERNATIVE SYNTAX:
-- WHERE age BETWEEN 21 AND 29;  (equivalent, simpler)

-- MULTIPLE AND CONDITIONS:
-- WHERE age > 20 AND age < 30 AND status = 'Active' AND salary > 40000;
-- All four conditions must be TRUE

-- WHEN TO USE AND:
-- - Narrow down results (AND = fewer rows)
-- - Multiple criteria all must be met
-- - Age range: age > 20 AND age < 30
-- - Status: status = 'Active' AND region = 'North'
-- - Combined filters: salary > 50000 AND years > 5 AND status = 'Employed'


-- ============================================================
-- 2. OR OPERATOR - AT LEAST ONE CONDITION TRUE
-- ============================================================
-- Example: Find customers with specific statuses
SELECT first_name, last_name, age
FROM customer_table
WHERE age < 20 OR age > 60;

-- EXPLANATION:
-- - Condition 1: age < 20 (young customers)
-- - Condition 2: age > 60 (senior customers)
-- - OR operator: At least ONE condition must be TRUE
-- - Returns: Customers who are young OR senior
-- - Excludes: Customers age 20-60 (neither condition true)

-- LOGIC TABLE FOR OR:
-- Condition1 | Condition2 | Result (OR)
-- True       | True       | TRUE ✓ (row included)
-- True       | False      | TRUE ✓ (row included)
-- False      | True       | TRUE ✓ (row included)
-- False      | False      | FALSE ✗ (row excluded)

-- EXAMPLE DATA:
-- | first_name | last_name | age |
-- |-----------|-----------|-----|
-- | John      | Smith     | 18  | (18 < 20: True) → INCLUDED ✓
-- | Sarah     | Johnson   | 22  | (22 < 20: False AND 22 > 60: False) → Excluded
-- | Michael   | Brown     | 65  | (65 > 60: True) → INCLUDED ✓
-- | David     | Lee       | 32  | (32 < 20: False AND 32 > 60: False) → Excluded
-- | Emma      | Wilson    | 19  | (19 < 20: True) → INCLUDED ✓

-- OUTPUT:
-- | first_name | last_name | age |
-- |-----------|-----------|-----|
-- | John      | Smith     | 18  |
-- | Michael   | Brown     | 65  |
-- | Emma      | Wilson    | 19  |

-- WHEN TO USE OR:
-- - Broaden results (OR = more rows than AND)
-- - Multiple criteria, at least one must be met
-- - Status: status = 'Active' OR status = 'Pending'
-- - Region: region = 'North' OR region = 'East'
-- - Multiple values: role IN ('Manager', 'Director') = role = 'Manager' OR role = 'Director'


-- ============================================================
-- 3. NOT OPERATOR - NEGATE A CONDITION
-- ============================================================
SELECT * 
FROM customer_table 
WHERE NOT age = 25 AND NOT first_name = 'Jay';

-- EXPLANATION:
-- - NOT age = 25: Excludes customers with age 25 (age != 25)
-- - NOT first_name = 'Jay': Excludes customers named Jay
-- - AND: Both NOT conditions must be TRUE
-- - Returns: All customers who are NOT 25 years old AND NOT named Jay

-- LOGIC TABLE FOR NOT:
-- Condition | Result (NOT)
-- True      | FALSE ✗
-- False     | TRUE ✓

-- AGE NOT EQUAL 25:
-- | first_name | age | age = 25 | NOT (age = 25) |
-- |-----------|-----|----------|----------------|
-- | John      | 18  | False    | TRUE ✓        |
-- | Sarah     | 22  | False    | TRUE ✓        |
-- | Michael   | 25  | True     | FALSE ✗       |
-- | David     | 30  | False    | TRUE ✓        |

-- FIRST_NAME NOT 'Jay':
-- | first_name | first_name = 'Jay' | NOT (first_name = 'Jay') |
-- |-----------|------------------|------------------------|
-- | John      | False            | TRUE ✓                |
-- | Jay       | True             | FALSE ✗              |
-- | Sarah     | False            | TRUE ✓               |

-- COMBINED (NOT age = 25 AND NOT first_name = 'Jay'):
-- Must satisfy BOTH conditions:
-- | first_name | age | NOT age=25 | NOT name='Jay' | Result (AND) |
-- |-----------|-----|-----------|---------------|-------------|
-- | John      | 18  | True      | True          | TRUE ✓     |
-- | Jay       | 22  | True      | False         | FALSE ✗    |
-- | Michael   | 25  | False     | True          | FALSE ✗    |
-- | Sarah     | 30  | True      | True          | TRUE ✓     |
-- | Jay       | 25  | False     | False         | FALSE ✗    |

-- ALTERNATIVE SYNTAX (same meaning):
-- WHERE age <> 25 AND first_name <> 'Jay';
-- WHERE age != 25 AND first_name != 'Jay';

-- WHEN TO USE NOT:
-- - Exclude specific values
-- - Negate conditions
-- - Find "everything except..."
-- - NOT status = 'Deleted'
-- - NOT is_archived = true
-- - NOT email LIKE '%@test.com'


-- ============================================================
-- 4. COMBINING AND, OR, NOT OPERATORS
-- ============================================================

-- Example: Complex filtering with multiple operators
SELECT * 
FROM customer_table
WHERE (age > 25 AND salary > 50000) OR (status = 'Manager' AND NOT department = 'Sales');

-- EXPLANATION:
-- - Parentheses define precedence/order
-- - Part 1: (age > 25 AND salary > 50000)
--   Employees over 25 earning more than 50k
-- - Part 2: (status = 'Manager' AND NOT department = 'Sales')
--   Managers not in Sales department
-- - OR: Rows matching EITHER part 1 OR part 2

-- EVALUATION ORDER:
-- 1. age > 25 AND salary > 50000 → TRUE or FALSE
-- 2. status = 'Manager' AND NOT department = 'Sales' → TRUE or FALSE
-- 3. Result1 OR Result2 → Final result


-- ============================================================
-- 5. OPERATOR PRECEDENCE
-- ============================================================

-- SQL evaluation order (without parentheses):
-- 1. NOT (highest priority)
-- 2. AND (medium priority)
-- 3. OR (lowest priority)

-- EXAMPLE:
-- WHERE condition1 OR condition2 AND condition3
-- Evaluated as: condition1 OR (condition2 AND condition3)
-- NOT: (condition1 OR condition2) AND condition3

-- RULE: Use parentheses to be explicit and avoid confusion
-- INSTEAD OF: WHERE age > 25 AND salary > 50000 OR status = 'Manager'
-- USE: WHERE (age > 25 AND salary > 50000) OR (status = 'Manager')

-- COMPARISON:
-- Without parentheses: (age > 25 AND salary > 50000) OR status = 'Manager'
-- With parentheses: Clear intent - evaluates this way anyway

-- Better readability when parentheses used


-- ============================================================
-- 6. AND vs OR COMPARISON
-- ============================================================

-- AND narrows results (fewer rows):
-- WHERE department = 'IT' AND salary > 60000
-- Result: Only IT employees earning over 60k
-- Rows reduced

-- OR broadens results (more rows):
-- WHERE department = 'IT' OR department = 'HR'
-- Result: All IT employees OR all HR employees
-- Rows increased

-- QUERY IMPACT:
-- AND: More restrictive, fewer results, faster query
-- OR: Less restrictive, more results, potentially slower

-- EXAMPLES:
-- AND (narrow): department = 'IT' AND role = 'Manager' AND years > 5
-- OR (broad): status = 'Active' OR status = 'Pending' OR status = 'OnHold'


-- ============================================================
-- 7. NOT WITH DIFFERENT CONDITIONS
-- ============================================================

-- NOT with equality:
-- WHERE NOT age = 25
-- Equivalent to: WHERE age <> 25 OR age != 25

-- NOT with comparison:
-- WHERE NOT age > 25
-- Equivalent to: WHERE age <= 25

-- NOT with LIKE:
-- WHERE NOT name LIKE 'John%'
-- Excludes names starting with John

-- NOT with IN:
-- WHERE NOT status IN ('Deleted', 'Inactive')
-- Equivalent to: WHERE status NOT IN ('Deleted', 'Inactive')

-- NOT with NULL:
-- WHERE NOT email IS NULL
-- Equivalent to: WHERE email IS NOT NULL


-- ============================================================
-- COMPLETE EXAMPLE - COMPLEX FILTERING
-- ============================================================

-- Find customers who:
-- - Are between 25-50 years old (AND for range)
-- - AND either have status='Active' OR salary > 80000
-- - AND are NOT in the 'Temp' department

SELECT customer_id, first_name, last_name, age, status, salary, department
FROM customer_table
WHERE (age >= 25 AND age <= 50)  -- Age range
  AND (status = 'Active' OR salary > 80000)  -- Status OR high salary
  AND NOT department = 'Temp';  -- NOT in Temp

-- LOGIC BREAKDOWN:
-- 1. Age 25-50: age >= 25 AND age <= 50
-- 2. Active OR high salary: status = 'Active' OR salary > 80000
-- 3. Not Temp: NOT department = 'Temp'
-- 4. All three conditions (AND) must be satisfied

-- EXAMPLE MATCHING ROWS:
-- | id | name     | age | status   | salary | department |
-- |----|----------|-----|----------|--------|-----------|
-- | 1  | Sarah    | 30  | Active   | 60000  | IT        | ✓ (All conditions met)
-- | 2  | Michael  | 45  | Inactive | 90000  | Sales     | ✓ (salary > 80000, others OK)
-- | 3  | John     | 22  | Active   | 60000  | IT        | ✗ (Age < 25)
-- | 4  | Emma     | 35  | Inactive | 50000  | Temp      | ✗ (Department = Temp)


-- ============================================================
-- BEST PRACTICES
-- ============================================================

-- 1. Use parentheses for clarity
-- Good:
-- WHERE (age > 25 AND salary > 50000) OR (status = 'Manager')
-- Bad:
-- WHERE age > 25 AND salary > 50000 OR status = 'Manager'
-- Reason: Explicit precedence, easier to read

-- 2. Order conditions logically
-- Good:
-- WHERE age >= 18 AND age <= 65 AND status = 'Active' AND department = 'Sales'
-- Bad:
-- WHERE status = 'Active' AND age >= 18 AND department = 'Sales' AND age <= 65
-- Reason: Grouped related conditions

-- 3. Use BETWEEN for ranges
-- Good:
-- WHERE age BETWEEN 25 AND 50
-- Bad:
-- WHERE age >= 25 AND age <= 50
-- Reason: Cleaner, more readable

-- 4. Use IN for multiple values
-- Good:
-- WHERE status IN ('Active', 'Pending', 'OnHold')
-- Bad:
-- WHERE status = 'Active' OR status = 'Pending' OR status = 'OnHold'
-- Reason: Shorter, cleaner

-- 5. Use NOT IN for exclusion
-- Good:
-- WHERE department NOT IN ('Temp', 'Intern', 'Contract')
-- Bad:
-- WHERE NOT department = 'Temp' AND NOT department = 'Intern' AND NOT department = 'Contract'
-- Reason: Much cleaner

-- 6. Document complex logic
-- -- Find active managers earning over 60k
-- WHERE status = 'Active' AND role = 'Manager' AND salary > 60000

-- 7. Test conditions separately
-- Test condition 1: WHERE age > 25
-- Test condition 2: WHERE salary > 50000
-- Test combined: WHERE age > 25 AND salary > 50000

-- 8. Avoid double negatives
-- Bad:
-- WHERE NOT status <> 'Active'
-- Good:
-- WHERE status = 'Active'
-- Reason: Clearer intent

-- 9. Use proper operators
-- Instead of: WHERE NOT age = 25
-- Better: WHERE age <> 25 OR age != 25
-- Reason: More explicit

-- 10. Index columns used in WHERE
-- CREATE INDEX idx_age ON customer_table(age);
-- CREATE INDEX idx_status ON customer_table(status);
-- Reason: Makes AND/OR conditions faster


-- ============================================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================================

-- 1. AND is faster than OR
-- AND: Filters out rows early, fewer comparisons
-- OR: Must check all conditions for each row

-- 2. Order conditions by selectivity
-- Put most selective condition first
-- Good: WHERE status = 'Active' AND age > 40
-- (If few are active, filter those first)

-- 3. Index the columns in WHERE
-- Indexed column: Fast filtering
-- Non-indexed column: Full table scan

-- 4. Avoid functions in WHERE
-- Slow: WHERE YEAR(created_date) = 2026
-- Fast: WHERE created_date >= '2026-01-01' AND created_date < '2027-01-01'

-- 5. Use appropriate data types
-- Better: status INT (lookup table)
-- Slower: status VARCHAR(50)

-- 6. Limit OR clauses
-- Many ORs can be slow
-- Better: Use IN operator
-- INSTEAD OF: OR OR OR OR OR
-- USE: IN (val1, val2, val3, val4, val5)


-- ============================================================
-- COMMON MISTAKES
-- ============================================================

-- MISTAKE 1: Wrong logical operator
-- Wrong: Find employees in IT OR Finance (but used AND)
-- SELECT * FROM employees WHERE department = 'IT' AND department = 'Finance';
-- Result: No rows (impossible - can't be both)
-- Correct: WHERE department = 'IT' OR department = 'Finance';

-- MISTAKE 2: Missing parentheses
-- Wrong: WHERE status = 'Active' OR role = 'Manager' AND salary > 50000
-- Means: (status = 'Active') OR (role = 'Manager' AND salary > 50000)
-- Correct: WHERE (status = 'Active' OR role = 'Manager') AND salary > 50000
-- (Different results!)

-- MISTAKE 3: Double NOT confusion
-- Wrong: WHERE NOT age <> 25 (means: age = 25, confusing)
-- Correct: WHERE age = 25

-- MISTAKE 4: AND when should be OR
-- Wrong: Find employees with various certifications
-- WHERE cert_java = 1 AND cert_python = 1 AND cert_dotnet = 1
-- (Finds employees with ALL certifications)
-- Correct: WHERE cert_java = 1 OR cert_python = 1 OR cert_dotnet = 1
-- (Finds employees with ANY certification)

-- MISTAKE 5: NULL handling with NOT
-- Wrong: WHERE NOT salary = 50000
-- Includes NULLs (because NULL = 50000 is unknown, NOT unknown = unknown)
-- Correct: WHERE salary <> 50000 OR salary IS NULL
-- (Explicitly handle NULLs)


-- ============================================================
-- TRUTH TABLE REFERENCE
-- ============================================================

-- AND TRUTH TABLE:
-- True AND True     = True
-- True AND False    = False
-- False AND True    = False
-- False AND False   = False
-- All conditions must be True for AND to return True

-- OR TRUTH TABLE:
-- True OR True      = True
-- True OR False     = True
-- False OR True     = True
-- False OR False    = False
-- At least one condition must be True for OR to return True

-- NOT TRUTH TABLE:
-- NOT True  = False
-- NOT False = True
-- Reverses the condition
