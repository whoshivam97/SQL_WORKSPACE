-- ============================================================
-- UPDATE STATEMENT - MODIFY EXISTING RECORDS
-- ============================================================
-- UPDATE changes values in existing rows
-- Syntax: UPDATE table SET column = value WHERE condition;
-- CRITICAL: Always use WHERE clause to target specific rows!
-- Without WHERE: ALL rows in table will be updated (dangerous!)


-- ============================================================
-- 1. UPDATE SINGLE COLUMN - SINGLE ROW
-- ============================================================
UPDATE customer_table 
SET age = 99, last_name = 'verma' 
WHERE cust_id = 1;

-- EXPLANATION:
-- - UPDATE customer_table: Target table to modify
-- - SET: Specifies what to change
-- - age = 99: Set age column to 99
-- - last_name = 'verma': Set last_name column to 'verma'
-- - WHERE cust_id = 1: Update ONLY the row where cust_id equals 1
-- - CRITICAL: WHERE clause specifies which row(s) to update

-- BEFORE UPDATE:
-- | cust_id | first_name | last_name | age | email          |
-- |---------|-----------|-----------|-----|----------------|
-- | 1       | John      | Smith     | 25  | john@email.com |

-- AFTER UPDATE:
-- | cust_id | first_name | last_name | age | email          |
-- |---------|-----------|-----------|-----|----------------|
-- | 1       | John      | verma     | 99  | john@email.com |
-- (last_name changed to 'verma', age changed to 99)
-- (first_name and email unchanged - not in SET clause)

-- ADVANTAGES:
-- - Precise: Only one specific record modified
-- - Safe: WHERE targets exact row
-- - Clear intent: Obvious what's changing

-- WHEN TO USE:
-- - Update one customer's information
-- - Correct data errors
-- - Change specific user settings
-- - Modify single record

-- SYNTAX:
-- UPDATE table_name SET column1 = value1 WHERE condition;


-- ============================================================
-- 2. UPDATE MULTIPLE COLUMNS - SINGLE ROW
-- ============================================================
-- Multiple columns separated by commas
UPDATE customer_table
SET age = 99, 
    last_name = 'verma', 
    email = 'verma@email.com'
WHERE cust_id = 1;

-- EXPLANATION:
-- - UPDATE: Modify table
-- - SET: Multiple columns separated by commas
--   age = 99
--   last_name = 'verma'
--   email = 'verma@email.com'
-- - WHERE cust_id = 1: Update only this customer
-- - Three columns changed in single UPDATE

-- BEFORE:
-- | cust_id | first_name | last_name | age | email          |
-- |---------|-----------|-----------|-----|----------------|
-- | 1       | John      | Smith     | 25  | john@email.com |

-- AFTER:
-- | cust_id | first_name | last_name | age | email            |
-- |---------|-----------|-----------|-----|------------------|
-- | 1       | John      | verma     | 99  | verma@email.com  |

-- ADVANTAGES:
-- - One UPDATE statement for multiple changes
-- - Atomic: All changes apply or none
-- - More efficient than separate UPDATEs

-- BEST PRACTICE:
-- Format with each column on new line for readability
-- Multiple columns separated by commas


-- ============================================================
-- 3. UPDATE MULTIPLE ROWS - WITH OR CONDITION
-- ============================================================
UPDATE customer_table 
SET email_id = 'xxxxx@gmail.com' 
WHERE first_name = 'raj' OR first_name = 'Shivam';

-- EXPLANATION:
-- - UPDATE customer_table: Target table
-- - SET email_id = 'xxxxx@gmail.com': Change email for matching rows
-- - WHERE first_name = 'raj' OR first_name = 'Shivam'
--   Update rows where first_name is either 'raj' or 'Shivam'
-- - Affects MULTIPLE rows matching the condition

-- BEFORE UPDATE:
-- | cust_id | first_name | last_name | email_id       |
-- |---------|-----------|-----------|----------------|
-- | 1       | raj       | Kumar     | raj@email.com  |
-- | 2       | John      | Smith     | john@email.com |
-- | 3       | Shivam    | Singh     | shivam@...     |
-- | 4       | Priya     | Gupta     | priya@email.com|

-- AFTER UPDATE:
-- | cust_id | first_name | last_name | email_id           |
-- |---------|-----------|-----------|-------------------|
-- | 1       | raj       | Kumar     | xxxxx@gmail.com   | ← updated
-- | 2       | John      | Smith     | john@email.com    | ← unchanged
-- | 3       | Shivam    | Singh     | xxxxx@gmail.com   | ← updated
-- | 4       | Priya     | Gupta     | priya@email.com   | ← unchanged

-- AFFECTED ROWS: 2 rows updated (raj and Shivam)

-- WHEN TO USE:
-- - Update multiple related records
-- - Change status for group of users
-- - Apply policy change to multiple records
-- - Bulk updates

-- OR vs AND:
-- OR: Updates rows matching ANY condition (more rows)
-- AND: Updates rows matching ALL conditions (fewer rows)

-- ALTERNATIVE SYNTAX (cleaner):
-- WHERE first_name IN ('raj', 'Shivam');
-- (Same result, cleaner syntax than OR)


-- ============================================================
-- 4. UPDATE WITH AND CONDITION (MULTIPLE CRITERIA)
-- ============================================================
UPDATE customer_table
SET status = 'Active'
WHERE age >= 18 AND status = 'Pending';

-- EXPLANATION:
-- - SET status = 'Active': Change status to Active
-- - WHERE age >= 18 AND status = 'Pending'
--   Update ONLY rows where BOTH conditions are true:
--   Condition 1: age >= 18 (18 or older)
--   Condition 2: status = 'Pending' (currently pending)
-- - Both conditions must be TRUE for row to be updated

-- EXAMPLE:
-- | cust_id | age | status  |
-- |---------|-----|---------|
-- | 1       | 16  | Pending | ← age < 18: NOT updated
-- | 2       | 20  | Pending | ← age >= 18 AND status = 'Pending': UPDATED ✓
-- | 3       | 25  | Active  | ← status != 'Pending': NOT updated
-- | 4       | 19  | Pending | ← age >= 18 AND status = 'Pending': UPDATED ✓

-- WHEN TO USE:
-- - Multiple filtering criteria
-- - Approve pending requests older than 18
-- - Update inactive accounts not accessed in 6 months
-- - Complex conditions


-- ============================================================
-- 5. UPDATE WITH IN OPERATOR
-- ============================================================
UPDATE customer_table
SET discount = 0.10
WHERE customer_id IN (101, 102, 103, 105);

-- EXPLANATION:
-- - SET discount = 0.10: Apply 10% discount
-- - WHERE customer_id IN (101, 102, 103, 105)
--   Update rows where customer_id is in the list
-- - Cleaner than: customer_id = 101 OR customer_id = 102 OR ...

-- AFFECTED ROWS:
-- | customer_id | discount |
-- |------------|----------|
-- | 101        | 0.10     | ← updated
-- | 102        | 0.10     | ← updated
-- | 103        | 0.10     | ← updated
-- | 104        | 0.00     | ← not in list
-- | 105        | 0.10     | ← updated

-- ADVANTAGES OVER OR:
-- - Cleaner syntax
-- - More readable
-- - More maintainable


-- ============================================================
-- 6. UPDATE WITH BETWEEN OPERATOR
-- ============================================================
UPDATE employee_table
SET salary = salary * 1.05
WHERE hire_date BETWEEN '2020-01-01' AND '2022-12-31';

-- EXPLANATION:
-- - SET salary = salary * 1.05: Increase salary by 5%
-- - WHERE hire_date BETWEEN dates: Range of dates
-- - Updates all employees hired during 2020-2022
-- - salary * 1.05: Multiplies current salary by 1.05 (5% raise)

-- EXAMPLE:
-- | emp_id | hire_date  | salary  |
-- |--------|-----------|---------|
-- | 1      | 2019-05-01| 60000   | ← before 2020: NOT updated
-- | 2      | 2020-03-15| 50000   | → 52500 (UPDATED ✓)
-- | 3      | 2021-07-20| 55000   | → 57750 (UPDATED ✓)
-- | 4      | 2023-01-10| 48000   | ← after 2022: NOT updated


-- ============================================================
-- 7. UPDATE WITH LIKE OPERATOR (PATTERN MATCHING)
-- ============================================================
UPDATE customer_table
SET email_verified = 1
WHERE email LIKE '%@gmail.com';

-- EXPLANATION:
-- - SET email_verified = 1: Mark as verified
-- - WHERE email LIKE '%@gmail.com'
--   Updates all Gmail accounts
-- - %: Wildcard matching any characters before @gmail.com

-- EXAMPLE:
-- | email              | email_verified |
-- |--------------------|----------------|
-- | john@gmail.com     | 1 (UPDATED ✓)  |
-- | sarah@yahoo.com    | 0 (NOT updated)|
-- | mike@gmail.com     | 1 (UPDATED ✓)  |
-- | lisa@outlook.com   | 0 (NOT updated)|

-- PATTERN EXAMPLES:
-- LIKE '%@gmail.com': Ends with @gmail.com
-- LIKE 'John%': Starts with John
-- LIKE '%test%': Contains test anywhere
-- LIKE '_o_n': Exactly 4 chars, has 'o' at pos 2, 'n' at pos 4


-- ============================================================
-- 8. UPDATE WITH CALCULATION
-- ============================================================
UPDATE orders
SET total_amount = quantity * unit_price * (1 - discount_percent/100)
WHERE status = 'Pending';

-- EXPLANATION:
-- - SET total_amount = calculation: Updates with formula
-- - Calculation: quantity * unit_price * (1 - discount_percent/100)
-- - Updates pending orders with correct amount

-- EXAMPLE:
-- | order_id | quantity | unit_price | discount_percent | total_amount |
-- |----------|----------|-----------|-----------------|--------------|
-- | 1        | 10       | 100       | 0               | 1000 (calc)  |
-- | 2        | 5        | 50        | 10              | 225 (calc)   |
-- (225 = 5 * 50 * (1 - 10/100) = 250 * 0.9)

-- COMMON CALCULATIONS:
-- Salary increase: salary = salary * 1.05 (5% raise)
-- Tax calculation: tax = amount * 0.10 (10% tax)
-- Discounted price: price = price * (1 - discount/100)
-- Age calculation: age = YEAR(CURRENT_DATE) - YEAR(birth_date)


-- ============================================================
-- 9. UPDATE WITH CASE STATEMENT (CONDITIONAL)
-- ============================================================
UPDATE products
SET category = CASE
    WHEN price < 50 THEN 'Budget'
    WHEN price BETWEEN 50 AND 100 THEN 'Standard'
    WHEN price > 100 THEN 'Premium'
END
WHERE category IS NULL;

-- EXPLANATION:
-- - CASE statement: Conditional update
-- - Different values based on conditions
-- - WHEN price < 50 THEN 'Budget'
-- - WHEN price BETWEEN 50 AND 100 THEN 'Standard'
-- - WHEN price > 100 THEN 'Premium'
-- - Categorizes products by price

-- EXAMPLE:
-- | product_id | price | category  |
-- |-----------|-------|-----------|
-- | 1         | 25    | Budget    | (< 50)
-- | 2         | 75    | Standard  | (50-100)
-- | 3         | 150   | Premium   | (> 100)


-- ============================================================
-- 10. UPDATE FROM SELECT (COPY DATA)
-- ============================================================
UPDATE customer_table c
SET email = s.new_email
FROM customer_staging s
WHERE c.customer_id = s.customer_id;

-- EXPLANATION:
-- - UPDATE table: Target table to modify
-- - SET column = subquery_column: Value from another table
-- - FROM source_table: Join with another table
-- - WHERE matching condition: How tables relate

-- USE CASES:
-- - Copy corrected data from staging table
-- - Sync data between tables
-- - Update multiple columns from related table


-- ============================================================
-- SAFETY BEST PRACTICES
-- ============================================================

-- 1. ALWAYS USE WHERE CLAUSE
-- Good:
-- UPDATE customer_table SET status = 'Active' WHERE status = 'Pending';
-- Bad:
-- UPDATE customer_table SET status = 'Active'; -- ALL rows updated!
-- Reason: WHERE clause specifies target rows

-- 2. TEST WITH SELECT FIRST
-- Before updating:
-- SELECT * FROM customer_table WHERE condition;
-- Verify you're updating the RIGHT rows
-- Then run: UPDATE customer_table SET ... WHERE condition;

-- 3. USE TRANSACTIONS FOR SAFETY
-- BEGIN TRANSACTION;
-- UPDATE customer_table SET ... WHERE ...;
-- -- Verify changes
-- COMMIT; -- or ROLLBACK; to undo

-- 4. BACKUP BEFORE BULK UPDATES
-- CREATE TABLE customer_backup AS
-- SELECT * FROM customer_table;
-- (Then run UPDATE)

-- 5. USE SPECIFIC CONDITIONS
-- Good:
-- UPDATE customer_table SET age = 25 WHERE customer_id = 1;
-- Bad:
-- UPDATE customer_table SET age = 25 WHERE customer_id IN (SELECT ...);
-- (Verify subquery first)

-- 6. CHECK AFFECTED ROW COUNT
-- UPDATE returns number of rows updated
-- Verify: Was the count expected?

-- 7. LOG YOUR UPDATES
-- -- Updated customer age from 20 to 25 on 2026-05-01
-- UPDATE customer_table SET age = 25 WHERE customer_id = 1;

-- 8. AVOID UPDATING PRIMARY KEYS
-- Don't: UPDATE customer_table SET customer_id = 2 WHERE customer_id = 1;
-- Reason: Breaks references and foreign keys

-- 9. VALIDATE DATA TYPES
-- Ensure value type matches column type
-- String values in quotes: 'text'
-- Numbers without quotes: 25

-- 10. HANDLE NULL VALUES CAREFULLY
-- UPDATE customer_table SET email = NULL WHERE ...
-- Use IS NULL or IS NOT NULL in WHERE


-- ============================================================
-- COMMON UPDATE SCENARIOS
-- ============================================================

-- Scenario 1: Correct data entry error
-- UPDATE customer_table SET last_name = 'Smith' 
-- WHERE customer_id = 1 AND last_name = 'Smth';

-- Scenario 2: Bulk status update
-- UPDATE orders SET status = 'Completed'
-- WHERE order_date < '2026-01-01' AND status = 'Pending';

-- Scenario 3: Apply discount to product category
-- UPDATE products SET price = price * 0.90
-- WHERE category = 'Electronics' AND price > 100;

-- Scenario 4: Mark inactive users
-- UPDATE users SET status = 'Inactive'
-- WHERE last_login < DATEADD(YEAR, -1, GETDATE());

-- Scenario 5: Reset failed login attempts
-- UPDATE user_accounts SET failed_attempts = 0
-- WHERE locked_until < GETDATE();

-- Scenario 6: Update all records (careful!)
-- UPDATE inventory SET stock_check_date = GETDATE()
-- WHERE stock_check_date IS NULL OR stock_check_date < DATEADD(MONTH, -1, GETDATE());

-- Scenario 7: Cascade update
-- UPDATE customer_table SET region = 'North America'
-- WHERE country IN ('USA', 'Canada', 'Mexico');


-- ============================================================
-- UPDATE vs OTHER OPERATIONS
-- ============================================================

-- UPDATE: Modifies existing rows
-- Example: UPDATE customer_table SET age = 30 WHERE ...

-- INSERT: Adds new rows
-- Example: INSERT INTO customer_table VALUES (1, 'John', ...)

-- DELETE: Removes rows
-- Example: DELETE FROM customer_table WHERE ...

-- TRUNCATE: Removes all rows (faster than DELETE)
-- Example: TRUNCATE TABLE customer_table;

-- REPLACE: Delete and insert (if supported)
-- Example: REPLACE INTO table VALUES (...)


-- ============================================================
-- PERFORMANCE OPTIMIZATION
-- ============================================================

-- 1. Index the WHERE columns
-- CREATE INDEX idx_status ON orders(status);
-- Makes: UPDATE orders SET ... WHERE status = 'Pending' (faster)

-- 2. Batch updates
-- UPDATE table SET ... WHERE id IN (select top 1000 id from table WHERE ...);
-- (Repeat for next batch) - prevents locking

-- 3. Avoid functions in WHERE
-- Good: WHERE created_date >= '2026-01-01'
-- Slow: WHERE YEAR(created_date) = 2026

-- 4. Update in batches for large tables
-- Don't update all 1 million rows at once
-- Update 10,000 rows per batch to avoid locks

-- 5. Consider offline backup approach
-- For very large updates:
-- 1. Create new table with updated data
-- 2. Rename tables (atomic switch)
-- 3. Drop old table


-- ============================================================
-- COMMON UPDATE ERRORS
-- ============================================================

-- ERROR: Syntax error in SET clause
-- Wrong: UPDATE table SET column1 = column2 = value;
-- Right: UPDATE table SET column1 = value, column2 = value;

-- ERROR: Missing WHERE clause
-- Wrong: UPDATE table SET status = 'Active';
-- (ALL rows updated!)
-- Right: UPDATE table SET status = 'Active' WHERE status = 'Pending';

-- ERROR: Type mismatch
-- Wrong: UPDATE table SET age = 'twenty-five' WHERE ...
-- (age is INT, 'twenty-five' is text)
-- Right: UPDATE table SET age = 25 WHERE ...

-- ERROR: Foreign key constraint violation
-- Can't update if it violates foreign key
-- Solution: Update related tables first

-- ERROR: Duplicate key violation
-- Can't update if creates duplicate in UNIQUE column
-- Solution: Check constraints before update


-- ============================================================
-- BEST PRACTICES SUMMARY
-- ============================================================

-- 1. Always use WHERE clause
-- 2. Test with SELECT first
-- 3. Use transactions for safety
-- 4. Backup before bulk updates
-- 5. Verify data types
-- 6. Log all updates
-- 7. Use meaningful conditions
-- 8. Handle NULL values properly
-- 9. Index WHERE columns
-- 10. Document why updates are needed



