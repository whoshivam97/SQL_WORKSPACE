-- ============================================================
-- INSERT STATEMENTS - ADD NEW RECORDS TO TABLE
-- ============================================================
-- INSERT adds new rows/records to a table
-- Syntax: INSERT INTO table [(columns)] VALUES (values);
-- Data must match column data types and constraints


-- ============================================================
-- METHOD 1: INSERT ALL COLUMNS IN ORDER
-- ============================================================
INSERT INTO customer_table 
VALUES (1, 'Shivam', 'Kumar', 28, 'bc@xyz.com');

-- EXPLANATION:
-- - INSERT INTO customer_table: Target table for insertion
-- - VALUES: Provides data for the new row
-- - (1, 'Shivam', 'Kumar', 28, 'bc@xyz.com'): Values in column order
-- - NO column list specified: Values must match ALL table columns in their order
-- - Values must match column data types:
--   1: Integer (customer_id)
--   'Shivam': Text/String (first_name)
--   'Kumar': Text/String (last_name)
--   28: Integer (age)
--   'bc@xyz.com': Text/String (email)

-- TABLE STRUCTURE EXPECTED:
-- | Column ID | Name         | Data Type      | Value        |
-- |-----------|--------------|----------------|--------------|
-- | 1         | customer_id  | INT            | 1            |
-- | 2         | first_name   | VARCHAR(100)   | 'Shivam'     |
-- | 3         | last_name    | VARCHAR(100)   | 'Kumar'      |
-- | 4         | age          | INT            | 28           |
-- | 5         | email        | VARCHAR(100)   | 'bc@xyz.com' |

-- REQUIREMENTS:
-- 1. Column order matters (no column list = use table order)
-- 2. Must provide values for ALL columns
-- 3. Data types must match exactly
-- 4. String values must be enclosed in single quotes
-- 5. Numbers do NOT need quotes

-- ADVANTAGES:
-- - Simple, concise syntax
-- - Fast for single row insertion

-- DISADVANTAGES:
-- - Error-prone if table has many columns
-- - Not clear which values go to which columns
-- - Breaks if table column order changes
-- - Harder to read and maintain

-- OUTPUT RESULT:
-- New row added to customer_table:
-- | cust_id | first_name | last_name | age | email        |
-- |---------|-----------|-----------|-----|--------------|
-- | 1       | Shivam    | Kumar     | 28  | bc@xyz.com   |


-- ============================================================
-- METHOD 2: INSERT WITH EXPLICIT COLUMN LIST
-- ============================================================
INSERT INTO customer_table (cust_id, first_name, age, email_id) 
VALUES (11, 'raj', 22, 'hde@haha.com');

-- EXPLANATION:
-- - INSERT INTO customer_table: Target table
-- - (cust_id, first_name, age, email_id): Explicit column list
-- - VALUES: Data values
-- - (11, 'raj', 22, 'hde@haha.com'): Values matching column list order
-- - NOT all columns specified: last_name is omitted

-- COLUMN MAPPING:
-- cust_id ← 11
-- first_name ← 'raj'
-- age ← 22
-- email_id ← 'hde@haha.com'
-- last_name ← NULL or DEFAULT (not specified)

-- TABLE COLUMNS:
-- cust_id: 11 (provided)
-- first_name: 'raj' (provided)
-- last_name: NULL (omitted - will be NULL if allows NULL, else error)
-- age: 22 (provided)
-- email_id: 'hde@haha.com' (provided)

-- ADVANTAGES:
-- - Clear which values go to which columns
-- - Can omit columns (they use DEFAULT or NULL)
-- - Column order in list doesn't have to match table order
-- - More readable and maintainable
-- - Less error-prone than Method 1
-- - Self-documenting code

-- DISADVANTAGES:
-- - Slightly more verbose than Method 1
-- - None significant - BEST PRACTICE

-- WHEN TO USE:
-- - Omitting some columns (more common)
-- - Columns in different order than table
-- - Multiple people working on code (clarity)
-- - Production code (safety and readability)

-- IMPORTANT NOTES:
-- - Column 'last_name' is missing
--   If it has DEFAULT value: Uses default
--   If it allows NULL: Sets to NULL
--   If NOT NULL and no DEFAULT: ERROR!

-- OUTPUT RESULT:
-- New row added to customer_table:
-- | cust_id | first_name | last_name | age | email_id       |
-- |---------|-----------|-----------|-----|----------------|
-- | 11      | raj       | NULL      | 22  | hde@haha.com   |


-- ============================================================
-- METHOD 3: INSERT MULTIPLE ROWS IN ONE STATEMENT
-- ============================================================
INSERT INTO customer_table 
VALUES (1, 'ss', 'sss', 43, 'shi@xyzm.com'),
       (1, 'sx', 'sssas', 3, 'saahi@xyzm.com'),
       (1, 'qs', 'saas', 413, 'sai@xyzm.com');

-- EXPLANATION:
-- - Single INSERT statement with multiple VALUE rows
-- - Each row in parentheses, separated by commas
-- - All rows inserted in one operation
-- - More efficient than three separate INSERT statements

-- ROW 1: (1, 'ss', 'sss', 43, 'shi@xyzm.com')
-- | cust_id | first_name | last_name | age | email        |
-- |---------|-----------|-----------|-----|--------------|
-- | 1       | ss        | sss       | 43  | shi@xyzm.com |

-- ROW 2: (1, 'sx', 'sssas', 3, 'saahi@xyzm.com')
-- | cust_id | first_name | last_name | age | email          |
-- |---------|-----------|-----------|-----|----------------|
-- | 1       | sx        | sssas     | 3   | saahi@xyzm.com |

-- ROW 3: (1, 'qs', 'saas', 413, 'sai@xyzm.com')
-- | cust_id | first_name | last_name | age | email        |
-- |---------|-----------|-----------|-----|--------------|
-- | 1       | qs        | saas      | 413 | sai@xyzm.com |

-- SYNTAX:
-- INSERT INTO table VALUES (values1), (values2), (values3), ... (valuesN);
-- Rows separated by commas, each row in parentheses

-- ADVANTAGES:
-- - Much faster than separate INSERT statements
-- - Atomic transaction: All rows inserted or none
-- - Cleaner code for multiple rows
-- - 5-10x faster than individual INSERTs
-- - Reduces network traffic (one command vs three)

-- DISADVANTAGES:
-- - If one row has error, entire statement fails
-- - Can be harder to read with many rows
-- - Max rows per statement varies by database (usually 1000-10000)

-- PERFORMANCE COMPARISON:
-- Three separate INSERT statements:
-- INSERT INTO customer_table VALUES (1, 'ss', 'sss', 43, 'shi@xyzm.com');
-- INSERT INTO customer_table VALUES (1, 'sx', 'sssas', 3, 'saahi@xyzm.com');
-- INSERT INTO customer_table VALUES (1, 'qs', 'saas', 413, 'sai@xyzm.com');
-- Execution time: 30ms (three separate operations)

-- Single bulk INSERT:
-- INSERT INTO customer_table VALUES (...), (...), (...);
-- Execution time: 3ms (one operation - 10x faster!)

-- WHEN TO USE:
-- - Adding multiple related records
-- - Bulk imports (better: use COPY/BULK INSERT)
-- - Data migrations
-- - Adding test data
-- - Always prefer multi-row INSERT over separate statements

-- WARNING - NOTE ON DATA QUALITY:
-- All three rows have cust_id = 1
-- This likely violates PRIMARY KEY constraint (if cust_id is PK)
-- You would get error: Duplicate key violation
-- Solution: Use unique customer IDs (1, 2, 3) instead


-- ============================================================
-- METHOD 4: INSERT WITH EXPLICIT COLUMNS - MULTIPLE ROWS
-- ============================================================
INSERT INTO customer_table (cust_id, first_name, last_name, age, email_id)
VALUES (20, 'John', 'Smith', 30, 'john@email.com'),
       (21, 'Sarah', 'Johnson', 28, 'sarah@email.com'),
       (22, 'Michael', 'Brown', 35, 'michael@email.com');

-- EXPLANATION:
-- - Combines explicit column list with multiple rows
-- - Best practice: Clear columns + bulk insert efficiency
-- - All rows follow same column order

-- BEST PRACTICE FORMAT:
-- INSERT INTO customer_table (cust_id, first_name, last_name, age, email_id)
-- VALUES (20, 'John', 'Smith', 30, 'john@email.com'),
--        (21, 'Sarah', 'Johnson', 28, 'sarah@email.com'),
--        (22, 'Michael', 'Brown', 35, 'michael@email.com');

-- ADVANTAGES:
-- - Explicit columns for clarity
-- - Bulk insert for speed
-- - Easy to read and maintain
-- - Self-documenting
-- - Correct use of unique IDs (20, 21, 22)

-- OUTPUT RESULT:
-- Three new rows with proper unique IDs


-- ============================================================
-- METHOD 5: INSERT FROM SELECT (COPY DATA FROM ANOTHER TABLE)
-- ============================================================
-- INSERT INTO customer_table
-- SELECT * FROM customer_table_backup
-- WHERE age > 25;

-- EXPLANATION:
-- - Inserts data from SELECT query results into table
-- - No VALUES keyword needed
-- - Useful for: Data migration, copying filtered data, duplicating records
-- - Data from SELECT must match column count and types

-- SELECT Result (example):
-- | cust_id | first_name | last_name | age | email          |
-- |---------|-----------|-----------|-----|----------------|
-- | 100     | Alice     | Lee       | 30  | alice@email.com|
-- | 101     | Bob       | White     | 28  | bob@email.com  |

-- All matching rows are inserted into customer_table

-- USE CASES:
-- - Backup: INSERT INTO backup SELECT * FROM live;
-- - Archive: INSERT INTO archive SELECT * FROM current WHERE created_date < '2020-01-01';
-- - Transform: INSERT INTO final SELECT * FROM staging WHERE validated = 1;

-- EXAMPLE:
-- -- Insert customers from another database
-- INSERT INTO customer_table (cust_id, first_name, age)
-- SELECT id, name, age_years FROM external_customers WHERE country = 'USA';


-- ============================================================
-- METHOD 6: INSERT WITH DEFAULT VALUES
-- ============================================================
-- INSERT INTO customer_table (cust_id, first_name, last_name)
-- VALUES (30, 'Jane', 'Doe');

-- EXPLANATION:
-- - age and email use DEFAULT or NULL if not specified
-- - If columns have DEFAULT values, they're used
-- - If columns allow NULL, they're set to NULL

-- EXAMPLE TABLE WITH DEFAULTS:
-- CREATE TABLE customer_table (
--     cust_id INT PRIMARY KEY,
--     first_name VARCHAR(100) NOT NULL,
--     last_name VARCHAR(100),
--     age INT DEFAULT 0,
--     email_id VARCHAR(100) DEFAULT 'noemail@unknown.com'
-- );

-- INSERT INTO customer_table (cust_id, first_name)
-- VALUES (30, 'Jane');

-- RESULT:
-- | cust_id | first_name | last_name | age | email_id           |
-- |---------|-----------|-----------|-----|-------------------|
-- | 30      | Jane      | NULL      | 0   | noemail@unknown.com|

-- age uses DEFAULT 0
-- email_id uses DEFAULT 'noemail@unknown.com'
-- last_name uses NULL (allows NULL)

-- WHEN TO USE:
-- - Some columns have sensible defaults
-- - Reduce data entry for optional fields
-- - Set timestamps: created_date DEFAULT GETDATE()


-- ============================================================
-- DATA TYPE REQUIREMENTS
-- ============================================================

-- STRING VALUES:
-- Must be enclosed in single quotes: 'text'
-- Example: 'Shivam', 'Kumar', 'bc@xyz.com'
-- Double quotes work in some databases but single quotes are standard

-- NUMERIC VALUES:
-- NO quotes needed for numbers
-- Example: 1, 28, 43, 413 (integers)
-- Example: 123.45, 99.99 (decimals)

-- DATE VALUES:
-- Usually in quotes with format: 'YYYY-MM-DD'
-- Example: '2026-05-01'
-- Different databases have different formats

-- BOOLEAN/BIT VALUES:
-- Usually: 0 (false) or 1 (true)
-- Some databases: true/false
-- Example: 1, 0

-- NULL VALUES:
-- Use NULL keyword (no quotes)
-- Example: INSERT INTO table VALUES (1, 'name', NULL, 25, NULL);


-- ============================================================
-- BEST PRACTICES FOR INSERT
-- ============================================================

-- 1. ALWAYS use explicit column list
-- Good:
-- INSERT INTO customer_table (cust_id, first_name, age, email_id)
-- VALUES (11, 'raj', 22, 'hde@haha.com');

-- Bad:
-- INSERT INTO customer_table VALUES (11, 'raj', 22, 'hde@haha.com');
-- Reason: Clear intent, maintainable if table columns change

-- 2. Use multiple rows for bulk insert
-- Good:
-- INSERT INTO customer_table (...) VALUES (...), (...), (...);

-- Bad:
-- INSERT INTO customer_table (...) VALUES (...);
-- INSERT INTO customer_table (...) VALUES (...);
-- INSERT INTO customer_table (...) VALUES (...);
-- Reason: Much faster, atomic transaction

-- 3. Ensure unique primary keys
-- Example table: cust_id is PRIMARY KEY
-- Good:
-- INSERT INTO customer_table VALUES (1, ...), (2, ...), (3, ...);
-- Bad:
-- INSERT INTO customer_table VALUES (1, ...), (1, ...), (1, ...);
-- Reason: Prevents duplicate key errors

-- 4. Validate data before insert
-- Check:
-- - Data types match column types
-- - Required fields are provided
-- - Values meet constraints (ranges, formats)
-- - No duplicate keys

-- 5. Use transactions for safety
-- BEGIN TRANSACTION;
-- INSERT INTO customer_table (...) VALUES (...), (...);
-- -- Verify success
-- COMMIT; -- or ROLLBACK;

-- 6. Include NOT NULL columns
-- If column is NOT NULL, must provide value
-- Don't skip it unless it has DEFAULT

-- 7. Document the insert
-- -- Insert new customer records from form submission 2026-05-01
-- INSERT INTO customer_table (...) VALUES (...);

-- 8. Test with sample data
-- Try inserting one row first
-- Verify it worked: SELECT * FROM customer_table WHERE cust_id = 1;
-- Then insert bulk data

-- 9. Use IDENTITY/AUTO_INCREMENT if available
-- -- Table auto-generates customer_id
-- INSERT INTO customer_table (first_name, age, email)
-- VALUES ('John', 30, 'john@email.com');
-- -- cust_id automatically assigned

-- 10. Handle errors gracefully
-- If insert fails:
-- - Check column names are correct
-- - Check data types match
-- - Check constraints (primary key, foreign key)
-- - Check file permissions for bulk insert


-- ============================================================
-- COMMON INSERT ERRORS AND SOLUTIONS
-- ============================================================

-- ERROR: Column count doesn't match value count
-- Example: INSERT INTO table (col1, col2) VALUES (val1, val2, val3);
-- Solution: Match number of columns to values

-- ERROR: Duplicate key value violates unique constraint
-- Example: INSERT INTO table VALUES (1, 'name'); -- cust_id=1 already exists
-- Solution: Use unique primary key value

-- ERROR: NOT NULL constraint violation
-- Example: INSERT INTO table (cust_id, name) VALUES (1, NULL);
-- When: last_name has NOT NULL constraint
-- Solution: Provide value for NOT NULL columns

-- ERROR: Data type mismatch
-- Example: INSERT INTO table (age) VALUES ('twenty-five');
-- When: age is INT column, 'twenty-five' is text
-- Solution: Use correct data type (25 instead of 'twenty-five')

-- ERROR: Foreign key constraint violation
-- Example: INSERT INTO orders (customer_id) VALUES (999);
-- When: customer_id=999 doesn't exist in customer table
-- Solution: Ensure referenced record exists first

-- ERROR: String too long for column
-- Example: INSERT INTO table (name) VALUES ('VeryLongNameExceeds100Chars...');
-- When: name is VARCHAR(100)
-- Solution: Truncate string or increase column size


-- ============================================================
-- PERFORMANCE OPTIMIZATION
-- ============================================================

-- 1. Batch multiple inserts
-- Time for 1000 individual inserts: ~10 seconds
-- Time for 1 bulk insert (1000 rows): ~100ms (100x faster!)

-- 2. Disable indexes during bulk insert
-- ALTER INDEX idx_name DISABLE;
-- INSERT INTO customer_table (...) VALUES (...), (...), ...;
-- ALTER INDEX idx_name REBUILD;

-- 3. Disable constraints temporarily (careful!)
-- ALTER TABLE customer_table DISABLE TRIGGER ALL;
-- INSERT INTO customer_table (...) VALUES (...), (...), ...;
-- ALTER TABLE customer_table ENABLE TRIGGER ALL;

-- 4. Use COPY/BULK INSERT for files
-- COPY customer_table FROM 'file.csv' WITH (FORMAT csv);
-- (Much faster than INSERT)

-- 5. Order inserts by foreign key
-- Insert parent records first, then child records
-- Prevents foreign key constraint errors

-- 6. Limit batch size
-- Insert in batches of 1000 rows, not all at once
-- Prevents memory overflow, easier error recovery


-- ============================================================
-- TRANSACTION SAFETY
-- ============================================================

-- Safe insert with transaction:
-- BEGIN TRANSACTION;
--
-- INSERT INTO customer_table (cust_id, first_name, age, email_id)
-- VALUES (11, 'raj', 22, 'hde@haha.com');
--
-- -- Verify insert
-- SELECT COUNT(*) FROM customer_table WHERE cust_id = 11;
--
-- COMMIT; -- Confirm the insert
-- -- OR ROLLBACK; -- Undo if something wrong

-- Benefits:
-- - All-or-nothing: Either all rows insert or none
-- - Can verify before committing
-- - Can undo if error detected
-- - Prevents partial updates


