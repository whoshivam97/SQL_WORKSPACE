-- ============================================================
-- BASIC ALTER TABLE OPERATIONS - MODIFY COLUMN STRUCTURE
-- ============================================================

-- 1. ADD A NEW COLUMN
-- ============================================================
ALTER TABLE customer_table 
ADD test VARCHAR(255);

-- EXPLANATION:
-- - Adds a new column named 'test' to the existing customer_table
-- - Data type is VARCHAR(255) - text field up to 255 characters
-- - New column is added to the end of the table
-- - All existing rows will have NULL value for this new column
-- - SYNTAX: ALTER TABLE [table_name] ADD [column_name] [data_type];
-- - You can add multiple columns: ADD col1 INT, col2 VARCHAR(100);


-- 2. DROP (DELETE) A COLUMN
-- ============================================================
ALTER TABLE customer_table 
DROP COLUMN test;

-- EXPLANATION:
-- - Removes/deletes the column named 'test' from customer_table
-- - ALL data in that column is permanently deleted
-- - Cannot be undone - use with caution!
-- - SYNTAX: ALTER TABLE [table_name] DROP COLUMN [column_name];
-- - Note: Some databases require DROP COLUMN keyword, some just DROP
-- - Important: Cannot drop column if it's referenced by constraints or indexes


-- 3. ALTER COLUMN - CHANGE DATA TYPE
-- ============================================================
ALTER TABLE customer_table 
ALTER COLUMN age TYPE VARCHAR(255);

-- EXPLANATION:
-- - Changes the data type of the 'age' column from INT to VARCHAR(255)
-- - VARCHAR(255) stores text instead of numbers
-- - Useful when data type needs to be changed (though risky with existing data)
-- - Data conversion may fail if current data doesn't match new type
-- - SYNTAX variations:
--   SQL Server: ALTER TABLE [table] ALTER COLUMN [col] [new_type];
--   PostgreSQL: ALTER TABLE [table] ALTER COLUMN [col] TYPE [new_type];
--   MySQL: ALTER TABLE [table] MODIFY COLUMN [col] [new_type];


-- 4. RENAME A COLUMN
-- ============================================================
ALTER TABLE customer_table 
RENAME COLUMN age TO person_age;

-- EXPLANATION:
-- - Changes column name from 'age' to 'person_age'
-- - Makes the column name more descriptive
-- - Data remains unchanged, only the name changes
-- - All queries referencing this column must use new name
-- - SYNTAX variations:
--   SQL Server: sp_rename 'customer_table.age', 'person_age';
--   PostgreSQL: ALTER TABLE customer_table RENAME COLUMN age TO person_age;
--   MySQL: ALTER TABLE customer_table CHANGE age person_age INT;
-- - Helpful for improving code readability and maintainability


-- ========================================
-- ADD/DROP CONSTRAINTS ON EXISTING TABLE
-- ========================================
-- WHAT ARE CONSTRAINTS?
-- Constraints are rules that enforce data integrity and consistency
-- They prevent invalid data from being inserted or updated
-- Types: PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK, DEFAULT, NOT NULL


-- 1. ADD PRIMARY KEY CONSTRAINT
-- ========================================
ALTER TABLE customer_table
ADD CONSTRAINT PK_CustomerID PRIMARY KEY (customer_id);

-- EXPLANATION:
-- - Creates a PRIMARY KEY constraint on customer_id column
-- - Ensures each customer_id is UNIQUE and NOT NULL
-- - Uniquely identifies each record in the table
-- - Only one primary key allowed per table
-- - WHEN TO USE: Always define a primary key for every table
-- - BEST PRACTICE: Use surrogate keys (auto-increment integers) for primary keys
-- - CONSTRAINT NAMING: Prefix with PK_ to identify primary keys
-- - If constraint already exists, will get error - drop first


-- 2. ADD FOREIGN KEY CONSTRAINT
-- ========================================
ALTER TABLE customer_table
ADD CONSTRAINT FK_CustomerOrder FOREIGN KEY (customer_id)
REFERENCES orders(customer_id);

-- EXPLANATION:
-- - Creates a FOREIGN KEY constraint linking customer_table to orders table
-- - Maintains referential integrity - customer_id must exist in orders table
-- - Prevents orphaned records (customers with non-existent orders)
-- - WHEN TO USE: When column references primary key in another table
-- - BEST PRACTICE: Use meaningful constraint names (FK_[SourceTable][ReferencedTable])
-- - Foreign key column must match type and size of referenced primary key
-- - Reference table must have a primary key on referenced column


-- With cascade options:
ALTER TABLE customer_table
ADD CONSTRAINT FK_CustomerDept FOREIGN KEY (dept_id)
REFERENCES departments(dept_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- EXPLANATION: Foreign key with CASCADE options
-- - ON DELETE CASCADE: Automatically deletes customer records when department is deleted
--   Use when: Child records should be removed with parent
-- - ON UPDATE CASCADE: Updates customer's dept_id when department id changes
--   Use when: Department ID changes must be reflected in all related records
-- - ALTERNATIVE OPTIONS:
--   ON DELETE RESTRICT: Prevents deletion if child records exist
--   ON DELETE SET NULL: Sets foreign key to NULL when parent deleted
--   ON UPDATE RESTRICT: Prevents updates if child records exist


-- 3. ADD UNIQUE CONSTRAINT
-- ========================================
ALTER TABLE customer_table
ADD CONSTRAINT UQ_Email UNIQUE (email);

-- EXPLANATION:
-- - Ensures email values are UNIQUE across all records
-- - No two customers can have the same email
-- - NULL values are allowed (SQL allows multiple NULLs in UNIQUE constraint)
-- - WHEN TO USE: For columns that should have unique values (email, username, SSN)
-- - CONSTRAINT NAMING: Prefix with UQ_ to identify unique constraints
-- - DIFFERENCE from PRIMARY KEY: Unique allows NULL, primary key doesn't
-- - Multiple unique constraints allowed per table (unlike primary key)


-- On multiple columns:
ALTER TABLE customer_table
ADD CONSTRAINT UQ_Username_Org UNIQUE (username, org_id);

-- EXPLANATION: Composite UNIQUE constraint on two columns
-- - Combination of (username, org_id) must be unique together
-- - Same username can exist if org_id is different
-- - WHEN TO USE: When uniqueness depends on multiple columns
-- - EXAMPLE: Username can repeat across organizations, but not within same org


-- 4. ADD CHECK CONSTRAINT
-- ========================================
ALTER TABLE customer_table
ADD CONSTRAINT CHK_Age CHECK (age > 0);

-- EXPLANATION:
-- - CHECK constraint validates that age is greater than 0
-- - Rejects any INSERT or UPDATE with age <= 0
-- - Ensures data integrity by enforcing business rules
-- - WHEN TO USE: To validate numeric ranges, text patterns, or conditions
-- - CONSTRAINT NAMING: Prefix with CHK_ to identify check constraints
-- - CHECK runs on every INSERT and UPDATE operation
-- - Can reference multiple columns in condition


-- Multiple conditions:
ALTER TABLE customer_table
ADD CONSTRAINT CHK_Status CHECK (status IN ('Active', 'Inactive', 'Pending'));

-- EXPLANATION: CHECK constraint with multiple conditions
-- - Restricts status column to only these three values
-- - Rejects any other value to maintain data consistency
-- - IN operator checks if value exists in list
-- - ALTERNATIVE: Use CHECK (status='Active' OR status='Inactive' OR status='Pending')


-- 5. ADD DEFAULT CONSTRAINT
-- ========================================
ALTER TABLE customer_table
ADD CONSTRAINT DF_JoinDate DEFAULT GETDATE() FOR join_date;

-- EXPLANATION:
-- - Assigns a default value to join_date column
-- - When a new record is inserted without specifying join_date, uses current date
-- - GETDATE() is SQL Server function for current date/time
-- - WHEN TO USE: For columns that have common/standard values
-- - CONSTRAINT NAMING: Prefix with DF_ to identify default constraints
-- - Functions vary by database: GETDATE() (SQL Server), NOW() (MySQL), CURRENT_DATE (PostgreSQL)
-- - Users can override default by explicitly providing a value


-- Alternative syntax:
ALTER TABLE customer_table
ADD CONSTRAINT DF_Status DEFAULT 'Active' FOR status;

-- EXPLANATION: Sets default value to 'Active' for status column
-- - If status not provided during INSERT, automatically sets to 'Active'
-- - Can use constants (text, numbers) or functions
-- - Useful for commonly used values to reduce data entry errors
-- - Reduces need to specify values for most records


-- 6. ADD NOT NULL CONSTRAINT
-- ========================================
ALTER TABLE customer_table
ALTER COLUMN email VARCHAR(100) NOT NULL;

-- EXPLANATION:
-- - Modifies email column to NOT NULL
-- - Every customer MUST have an email address
-- - Rejects INSERT or UPDATE without email value
-- - Ensures this field is always populated
-- - WHEN TO USE: For required columns (email, name, ID, etc.)
-- - NOTE: Cannot add NOT NULL to column with existing NULL values
-- - SOLUTION: Update/remove NULL values first, then add constraint
-- - SYNTAX varies by database (shown is SQL Server/standard SQL)


-- ========================================
-- DROP CONSTRAINTS - REMOVE VALIDATION RULES
-- ========================================
-- IMPORTANT: Use DROP carefully - removing constraints removes data validation
-- Always document why a constraint is being removed


-- 7. DROP PRIMARY KEY
-- ========================================
ALTER TABLE customer_table
DROP CONSTRAINT PK_CustomerID;

-- EXPLANATION:
-- - Removes the PRIMARY KEY constraint from customer_id
-- - customer_id is no longer the unique identifier
-- - Allows duplicate customer_id values (not recommended)
-- - Must drop dependent foreign keys first (foreign keys reference primary key)
-- - WHEN TO USE: Rarely - usually for restructuring database
-- - WARNING: Removes uniqueness guarantee - data integrity compromised
-- - After dropping, re-add with ADD CONSTRAINT if need to restore


-- 8. DROP FOREIGN KEY
-- ========================================
ALTER TABLE customer_table
DROP CONSTRAINT FK_CustomerOrder;

-- EXPLANATION:
-- - Removes the FOREIGN KEY constraint
-- - Breaks the relationship with orders table
-- - customer_id values no longer need to exist in orders table
-- - Allows orphaned records in customer_table (records without matching parent)
-- - WHEN TO USE: When restructuring tables or removing relationships
-- - WARNING: May create data integrity issues - orphaned records can appear
-- - DEPENDENCY: Must drop child foreign key before dropping parent primary key


-- 9. DROP UNIQUE CONSTRAINT
-- ========================================
ALTER TABLE customer_table
DROP CONSTRAINT UQ_Email;

-- EXPLANATION:
-- - Removes the UNIQUE constraint from email column
-- - Duplicate email addresses are now allowed
-- - Multiple customers can have the same email
-- - WHEN TO USE: When business rule changes or data needs consolidation
-- - IMPACT: Less strict validation - data quality may degrade


-- 10. DROP CHECK CONSTRAINT
-- ========================================
ALTER TABLE customer_table
DROP CONSTRAINT CHK_Age;

-- EXPLANATION:
-- - Removes the CHECK constraint on age column
-- - Age validation is removed
-- - Can now insert age values <= 0 or any other value
-- - No validation on what gets stored in age column
-- - WHEN TO USE: When validation rules become outdated or change
-- - WARNING: Invalid data may be added after constraint removed


-- 11. DROP DEFAULT CONSTRAINT
-- ========================================
ALTER TABLE customer_table
DROP CONSTRAINT DF_JoinDate;

-- EXPLANATION:
-- - Removes the DEFAULT constraint from join_date
-- - New records require explicit join_date value
-- - If not provided, join_date will be NULL
-- - WHEN TO USE: When default value no longer applies to new records
-- - IMPACT: Users must now provide value, increasing data entry work


-- ========================================
-- COMPLETE EXAMPLE: Add/Drop Multiple Constraints on customer_table
-- ========================================
-- This section shows how to add all constraint types together,
-- then demonstrates removing them


-- Add Multiple Constraints:
-- Step 1: Add Primary Key
ALTER TABLE customer_table
ADD CONSTRAINT PK_CustomerID PRIMARY KEY (customer_id);
-- Now customer_id uniquely identifies each row

-- Step 2: Add Unique Email
ALTER TABLE customer_table
ADD CONSTRAINT UQ_CustomerEmail UNIQUE (email);
-- Ensures no duplicate emails - each customer has unique email

-- Step 3: Add Age Validation
ALTER TABLE customer_table
ADD CONSTRAINT CHK_ValidAge CHECK (age >= 18 AND age <= 120);
-- Only allows realistic ages between 18-120 years

-- Step 4: Add Default Join Date
ALTER TABLE customer_table
ADD CONSTRAINT DF_JoinDate DEFAULT GETDATE() FOR join_date;
-- Automatically sets today's date for new customers


-- Drop Constraints (in reverse order):
-- Step 1: Remove Default Constraint
ALTER TABLE customer_table
DROP CONSTRAINT DF_JoinDate;
-- Now must explicitly provide join_date

-- Step 2: Remove Check Constraint
ALTER TABLE customer_table
DROP CONSTRAINT UQ_CustomerEmail;
-- Duplicate emails are now allowed

-- Step 3: Remove Check Constraint
ALTER TABLE customer_table
DROP CONSTRAINT CHK_ValidAge;
-- Age validation removed - any age value accepted

-- Step 4: Remove Primary Key
ALTER TABLE customer_table
DROP CONSTRAINT PK_CustomerID;
-- customer_id no longer guaranteed unique


-- ========================================
-- QUICK REFERENCE - CONSTRAINT NAMING CONVENTIONS
-- ========================================
-- PK_[TableName][Column]      - Primary Key
-- FK_[ChildTable][ParentTable] - Foreign Key
-- UQ_[TableName][Column]      - Unique
-- CHK_[TableName][Column]     - Check
-- DF_[TableName][Column]      - Default

-- EXAMPLE: For customer_table with customer_id
-- PK_CustomerTable_CustomerID
-- UQ_CustomerTable_Email
-- CHK_CustomerTable_Age
-- DF_CustomerTable_JoinDate


-- ========================================
-- DATABASE-SPECIFIC SYNTAX VARIATIONS
-- ========================================

-- SQL SERVER:
-- ADD CONSTRAINT DF_JoinDate DEFAULT GETDATE() FOR join_date;
-- DROP CONSTRAINT constraint_name;

-- MYSQL:
-- ALTER TABLE table_name ADD CONSTRAINT pk_name PRIMARY KEY (col);
-- ALTER TABLE table_name ADD UNIQUE KEY uk_name (col);
-- ALTER TABLE table_name DROP FOREIGN KEY fk_name;
-- ALTER TABLE table_name DROP INDEX uk_name; (for unique)

-- POSTGRESQL:
-- ALTER TABLE table_name ADD CONSTRAINT pk_name PRIMARY KEY (col);
-- ALTER TABLE table_name ADD CONSTRAINT fk_name FOREIGN KEY (col) REFERENCES parent_table(col);
-- ALTER TABLE table_name DROP CONSTRAINT constraint_name;

-- ORACLE:
-- ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY (col);
-- ALTER TABLE table_name DROP CONSTRAINT constraint_name;


-- ========================================
-- BEST PRACTICES SUMMARY
-- ========================================

-- 1. ALWAYS add PRIMARY KEY to every table
--    - Uniquely identifies each row
--    - Required for referential integrity
--    - Use auto-increment integer (surrogate key) when possible

-- 2. Use FOREIGN KEYS to maintain relationships
--    - Prevents orphaned data
--    - Consider CASCADE options based on business needs
--    - Document which table is parent/child

-- 3. Use UNIQUE constraints for natural unique values
--    - Email, username, SSN, account number, etc.
--    - Different from PRIMARY KEY (allows NULL)
--    - Can have multiple per table

-- 4. Use CHECK constraints for business rules
--    - Validate ranges (age, salary, quantity)
--    - Validate allowed values (status, gender)
--    - Prevents invalid data entry

-- 5. Use DEFAULT values for common data
--    - Reduces data entry errors
--    - Examples: created_date = GETDATE(), status = 'Active'
--    - Can use functions or constants

-- 6. Use NOT NULL for required fields
--    - Ensures critical data always exists
--    - Apply to natural identifiers, names, required info
--    - Cannot add if column already has NULL values

-- 7. Document all constraints
--    - Explain why each constraint exists
--    - Include business rules
--    - Help future developers understand design

-- 8. Test before dropping constraints
--    - Understand impact on referential integrity
--    - Check for dependent objects
--    - Have backup/rollback plan

-- 9. Use meaningful constraint names
--    - Follow company naming convention
--    - Makes debugging and modification easier
--    - Helps identify constraint purpose quickly

-- 10. Order of operations when dropping:
--    - Drop child FOREIGN KEYS first
--    - Then drop parent PRIMARY KEY
--    - Drop other constraints as needed



