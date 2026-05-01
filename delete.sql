-- ============================================================
-- DELETE STATEMENT - REMOVE RECORDS FROM A TABLE
-- ============================================================
-- IMPORTANT: DELETE removes data permanently! Always use WHERE clause
-- BACKUP your data before running DELETE statements
-- Test SELECT first to verify which records will be deleted


-- ============================================================
-- 1. DELETE SINGLE RECORD BY PRIMARY KEY
-- ============================================================
DELETE FROM customer_table 
WHERE cust_id = 1;

-- EXPLANATION:
-- - Deletes the complete record where cust_id equals 1
-- - Removes ALL columns of that row (entire record deleted)
-- - WHERE clause specifies which record(s) to delete
-- - IMPORTANT: Always use WHERE to target specific records
-- - If WHERE omitted: ALL records in table deleted (catastrophic!)
-- - SYNTAX: DELETE FROM [table_name] WHERE [condition];
-- - Return value: Number of rows affected/deleted
-- - This is the SAFEST way to delete - single record by ID


-- SAFETY TIP: First verify the record exists
-- Run this first to confirm:
-- SELECT * FROM customer_table WHERE cust_id = 1;
-- Then run the DELETE if result is correct


-- ============================================================
-- 2. DELETE MULTIPLE RECORDS BY CONDITION
-- ============================================================
DELETE FROM customer_table 
WHERE age > 30;

-- EXPLANATION:
-- - Deletes ALL records where age is greater than 30
-- - Removes multiple rows in one operation
-- - WHERE condition defines which records match
-- - EXAMPLE CONDITIONS:
--   WHERE salary < 30000       (less than operator)
--   WHERE status = 'Inactive'  (exact match)
--   WHERE name LIKE 'A%'       (starts with A)
--   WHERE age > 30 AND status = 'Inactive'  (multiple conditions)
-- - IMPACT: Affects all matching records at once
-- - WARNING: Can delete many records unintentionally


-- SAFETY TIP: Always preview before deleting
-- Run this first to COUNT how many records will be deleted:
-- SELECT COUNT(*) FROM customer_table WHERE age > 30;
-- Or see what will be deleted:
-- SELECT * FROM customer_table WHERE age > 30;
-- Then verify this is correct before running DELETE


-- ============================================================
-- 3. DELETE WITH AND CONDITION (Multiple Criteria)
-- ============================================================
DELETE FROM customer_table
WHERE age > 30 AND status = 'Inactive';

-- EXPLANATION:
-- - Deletes records matching ALL conditions (AND logic)
-- - Record must be age > 30 AND status = 'Inactive' to be deleted
-- - Both conditions must be TRUE for deletion
-- - SYNTAX: WHERE condition1 AND condition2 AND condition3...
-- - EXAMPLE: WHERE dept_id = 5 AND salary < 25000 AND years_employed < 2
--   (Delete contract workers in IT with salary under 25k hired less than 2 years ago)
-- - More conditions = fewer records deleted


-- ============================================================
-- 4. DELETE WITH OR CONDITION (Any Criteria)
-- ============================================================
DELETE FROM customer_table
WHERE status = 'Inactive' OR status = 'Suspended';

-- EXPLANATION:
-- - Deletes records matching ANY condition (OR logic)
-- - Record deleted if status is 'Inactive' OR 'Suspended'
-- - Only one condition needs to be TRUE for deletion
-- - SYNTAX: WHERE condition1 OR condition2 OR condition3...
-- - EXAMPLE: WHERE status = 'Cancelled' OR age > 120 OR email IS NULL
-- - Fewer conditions = more records deleted


-- ============================================================
-- 5. DELETE WITH IN OPERATOR (Multiple Values)
-- ============================================================
DELETE FROM customer_table
WHERE cust_id IN (1, 5, 10, 15);

-- EXPLANATION:
-- - Deletes records where cust_id is 1, 5, 10, or 15
-- - IN operator checks if value exists in list
-- - Cleaner than: WHERE cust_id=1 OR cust_id=5 OR cust_id=10
-- - SYNTAX: WHERE column IN (value1, value2, value3...);
-- - EXAMPLE: WHERE status IN ('Inactive', 'Deleted', 'Closed')
-- - EXAMPLE: WHERE region IN ('East', 'West', 'South')
-- - Useful for deleting specific set of records


-- ============================================================
-- 6. DELETE WITH BETWEEN OPERATOR (Range)
-- ============================================================
DELETE FROM customer_table
WHERE age BETWEEN 50 AND 60;

-- EXPLANATION:
-- - Deletes records where age is between 50 AND 60 (inclusive)
-- - Includes both boundaries: age >= 50 AND age <= 60
-- - SYNTAX: WHERE column BETWEEN value1 AND value2;
-- - EXAMPLE: WHERE join_date BETWEEN '2020-01-01' AND '2020-12-31'
--   (Delete all customers who joined in 2020)
-- - EXAMPLE: WHERE salary BETWEEN 40000 AND 60000
--   (Delete all employees in the $40k-60k salary range)
-- - Useful for deleting ranges of data


-- ============================================================
-- 7. DELETE WITH LIKE OPERATOR (Pattern Matching)
-- ============================================================
DELETE FROM customer_table
WHERE name LIKE 'John%';

-- EXPLANATION:
-- - Deletes records where name starts with 'John'
-- - LIKE operator matches text patterns
-- - '%' wildcard = any characters
-- - PATTERN EXAMPLES:
--   'John%'    = Starts with John (John, Johnny, Johnston)
--   '%John'    = Ends with John (Big John)
--   '%John%'   = Contains John anywhere
--   'J_hn'     = Exactly 4 chars, starts with J, ends with hn
-- - EXAMPLE: WHERE email LIKE '%@gmail.com' (delete Gmail users)
-- - Case sensitivity depends on database settings


-- ============================================================
-- 8. DELETE WITH IS NULL (Missing Values)
-- ============================================================
DELETE FROM customer_table
WHERE email IS NULL;

-- EXPLANATION:
-- - Deletes records where email column is empty/NULL
-- - IS NULL checks for missing/empty values
-- - NOT IS NULL checks for non-empty values
-- - SYNTAX: WHERE column IS NULL;
-- - EXAMPLE: WHERE phone_number IS NOT NULL
--   (Delete records that have a phone number)
-- - USEFUL: Clean up incomplete records
-- - NOTE: Use IS NULL, not = NULL (NULL comparisons are special)


-- ============================================================
-- 9. DELETE ALL RECORDS (USE WITH EXTREME CAUTION!)
-- ============================================================
-- DELETE FROM customer_table;
-- COMMENTED OUT - Extremely dangerous!

-- EXPLANATION:
-- - Deletes EVERY record in the table
-- - No WHERE clause = ALL records deleted
-- - Table structure remains, but all data is gone
-- - CATASTROPHIC: Data loss cannot be undone!
-- - ONLY USE IF: You intentionally want to empty the entire table
-- - SAFER ALTERNATIVE: Drop and recreate table if you need empty table
-- - MUST HAVE: Backup before attempting this
-- - BETTER PRACTICE: Use WHERE clause always


-- ============================================================
-- SAFETY BEST PRACTICES
-- ============================================================

-- 1. ALWAYS TEST FIRST WITH SELECT
-- Example: Before deleting, run:
-- SELECT * FROM customer_table WHERE age > 30;
-- Verify you're deleting the RIGHT records

-- 2. USE TRANSACTIONS FOR SAFETY
-- BEGIN TRANSACTION;
-- DELETE FROM customer_table WHERE age > 30;
-- -- Review the impact, then:
-- COMMIT;  -- To confirm deletion
-- -- Or ROLLBACK; to undo

-- 3. CREATE BACKUP BEFORE DELETE
-- CREATE TABLE customer_table_backup AS 
-- SELECT * FROM customer_table;
-- -- Now safe to delete from original

-- 4. USE WHERE CLAUSE ALWAYS
-- Never delete without WHERE clause unless intentional

-- 5. CHECK FOREIGN KEY CONSTRAINTS
-- Deleting parent record may fail if child records exist
-- Example: Cannot delete customer if orders reference that customer

-- 6. VERIFY COUNT FIRST
-- SELECT COUNT(*) FROM customer_table WHERE age > 30;
-- Know how many records will be deleted before deletion

-- 7. DOCUMENT YOUR DELETIONS
-- Add comments explaining why records are being deleted
-- Include date and reason: -- Delete inactive accounts as of 2026-05-01

-- 8. USE DELETE WITH CAUTION
-- DELETE is permanent - cannot be undone without backup
-- TRUNCATE is faster but harder to recover from
-- DROP deletes entire table structure


-- ============================================================
-- COMMON DELETE SCENARIOS
-- ============================================================

-- Scenario 1: Delete a single customer by ID
-- DELETE FROM customer_table WHERE cust_id = 5;

-- Scenario 2: Delete all inactive accounts
-- DELETE FROM customer_table WHERE status = 'Inactive';

-- Scenario 3: Delete customers who haven't logged in for 1 year
-- DELETE FROM customer_table WHERE last_login < DATEADD(YEAR, -1, GETDATE());

-- Scenario 4: Delete test/temporary records
-- DELETE FROM customer_table WHERE name LIKE 'TEST%' OR name LIKE 'TEMP%';

-- Scenario 5: Delete duplicate email addresses
-- DELETE FROM customer_table 
-- WHERE cust_id NOT IN (SELECT MIN(cust_id) FROM customer_table GROUP BY email);

-- Scenario 6: Delete old archive records
-- DELETE FROM customer_table WHERE created_date < '2020-01-01';

-- Scenario 7: Delete records with missing required data
-- DELETE FROM customer_table WHERE phone IS NULL AND email IS NULL;


-- ============================================================
-- DELETE vs OTHER OPERATIONS
-- ============================================================

-- DELETE vs TRUNCATE:
-- DELETE: Slower, can use WHERE, can ROLLBACK, frees some space
-- TRUNCATE: Faster, no WHERE, harder to ROLLBACK, frees table space

-- DELETE vs DROP:
-- DELETE: Removes rows, keeps table structure, can use WHERE
-- DROP: Removes entire table (structure + data), cannot use WHERE

-- DELETE vs UPDATE:
-- DELETE: Removes rows completely
-- UPDATE: Modifies column values, keeps rows
-- Example: DELETE removes customer entirely
--          UPDATE sets status='Inactive' but keeps customer record


-- ============================================================
-- PERFORMANCE TIPS
-- ============================================================

-- 1. Delete in batches for large datasets
-- DELETE FROM customer_table WHERE age > 30 LIMIT 1000;
-- DELETE FROM customer_table WHERE age > 30 LIMIT 1000;
-- (Repeat until done) - prevents locking

-- 2. Index on WHERE columns for faster deletion
-- CREATE INDEX idx_age ON customer_table(age);
-- Then DELETE WHERE age > 30 runs faster

-- 3. Disable foreign key checks temporarily (if safe)
-- ALTER TABLE customer_table DISABLE TRIGGER tr_fk;
-- DELETE FROM customer_table WHERE age > 30;
-- ALTER TABLE customer_table ENABLE TRIGGER tr_fk;

-- 4. Archive data instead of deleting
-- INSERT INTO customer_table_archive SELECT * FROM customer_table WHERE age > 30;
-- DELETE FROM customer_table WHERE age > 30;
-- Keeps historical records


