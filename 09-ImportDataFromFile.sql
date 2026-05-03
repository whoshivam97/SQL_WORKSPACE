-- ============================================================
-- IMPORT DATA FROM FILES - BULK LOAD DATA INTO TABLES
-- ============================================================
-- Methods to load data from external files (CSV, text, etc.) into SQL tables
-- Useful for: Data migrations, bulk imports, initial data loading


-- ============================================================
-- METHOD 1: COPY COMMAND - CSV FORMAT (PostgreSQL)
-- ============================================================
COPY customer_table 
FROM 'C:\tmp\copy.csv' 
WITH (FORMAT csv, HEADER true);

-- EXPLANATION:
-- - COPY: PostgreSQL command for bulk importing data
-- - customer_table: Target table (must exist first)
-- - FROM 'C:\tmp\copy.csv': Source file path (Windows format)
-- - FORMAT csv: Treats file as CSV (comma-separated values)
-- - HEADER true: First row contains column names (skipped during import)
-- - CSV FILE STRUCTURE:
--   First line: name,age,email (column names - SKIPPED)
--   Data lines: John,25,john@email.com
--               Sarah,30,sarah@email.com
--   (Actual data imported starting from line 2)

-- REQUIREMENTS:
-- 1. File must exist at specified path
-- 2. Table must exist with matching columns
-- 3. Data types must match column types
-- 4. File must be readable by database server

-- COLUMN MAPPING:
-- - Columns matched by order or name (HEADER true matches by name)
-- - If columns in file differ from table, use column list:
--   COPY customer_table (name, age, email) FROM 'C:\tmp\copy.csv' WITH (FORMAT csv, HEADER true);

-- ERROR HANDLING:
-- - If data doesn't match column type: ERROR
-- - Solution: Check data types in CSV file match table columns
-- - Use DELIMITER if commas not used as separator

-- EXAMPLE CSV FILE CONTENT:
-- name,age,email
-- John,25,john@email.com
-- Sarah,30,sarah@email.com
-- Michael,35,michael@email.com


-- ============================================================
-- METHOD 2: COPY COMMAND - TEXT FORMAT WITH DELIMITER
-- ============================================================
COPY customer_table
FROM 'C:\\tmp\\copytext.txt'
WITH (FORMAT text, DELIMITER ',', HEADER true);

-- EXPLANATION:
-- - COPY: PostgreSQL bulk import command
-- - customer_table: Target table (must exist)
-- - FROM 'C:\\tmp\\copytext.txt': Source file path (double backslashes for Windows)
-- - FORMAT text: Plain text format (not CSV-specific parsing)
-- - DELIMITER ',': Uses comma as field separator
--   (Can be any character: '|', '\t' (tab), ';', etc.)
-- - HEADER true: First row contains column names (skipped)

-- PATH NOTATION:
-- Windows: 'C:\\tmp\\copytext.txt' (double backslashes)
-- Unix/Linux: '/tmp/copytext.txt' (forward slashes)
-- Relative path: 'data/copytext.txt' (relative to current directory)

-- DELIMITER OPTIONS:
-- ',' : Comma (most common)
-- '|' : Pipe symbol
-- '\t' : Tab character
-- ';' : Semicolon
-- ' ' : Space

-- TEXT FILE STRUCTURE:
-- First line: name,age,email (column names - SKIPPED because HEADER true)
-- Data: John,25,john@email.com
--       Sarah,30,sarah@email.com

-- WHEN TO USE TEXT vs CSV:
-- TEXT: When using custom delimiters (pipes, tabs, semicolons)
-- CSV: When data is standard comma-separated
-- TEXT: For older systems using non-CSV format


-- ============================================================
-- METHOD 3: COPY WITH COLUMN SPECIFICATION
-- ============================================================
COPY customer_table (customer_id, name, age, email)
FROM 'C:\tmp\copy.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER true);

-- EXPLANATION:
-- - Explicitly lists which columns to import
-- - (customer_id, name, age, email): Import order
-- - Table may have more columns (others set to DEFAULT or NULL)
-- - Columns in file must match this order
-- - Useful when: Table has more columns than file
-- - Example: Table has customer_id, name, age, email, phone
--           But file only has: name, age, email
--           Then specify: COPY customer_table (name, age, email) FROM ...

-- USE CASE:
-- Table: customer_table (customer_id, name, age, email, phone, created_date)
-- File: copy.csv has only (name, age, email)
-- Command: COPY customer_table (name, age, email) FROM 'C:\tmp\copy.csv' ...
-- Result: phone and created_date filled with NULL or DEFAULT values


-- ============================================================
-- METHOD 4: COPY WITH QUOTE CHARACTER HANDLING
-- ============================================================
COPY customer_table
FROM 'C:\tmp\copy.csv'
WITH (FORMAT csv, HEADER true, QUOTE '"', ESCAPE '\');

-- EXPLANATION:
-- - QUOTE '"': Character used for quoted fields (default is double quote)
-- - ESCAPE '\': Escape character for quotes within data
-- - Handles data containing commas or special characters
-- - CSV FILE EXAMPLE:
--   name,age,email
--   "Smith, John",25,"john@email.com"
--   "O'Brien, Sarah",30,"sarah@email.com"
--   (Names with commas wrapped in quotes)

-- WHEN NEEDED:
-- - Data contains the delimiter character (comma)
-- - Data contains newlines
-- - Data contains the quote character itself

-- QUOTE OPTIONS:
-- QUOTE '"' : Use double quotes for fields (standard CSV)
-- QUOTE '''' : Use single quotes
-- QUOTE OFF : No quote character (data shouldn't have delimiters in it)

-- ESCAPE EXAMPLES:
-- ESCAPE '\' : Backslash escapes special characters
-- Escape quote: "Smith said ""Hello"""  →  Smith said "Hello"


-- ============================================================
-- METHOD 5: SQL SERVER - BULK INSERT
-- ============================================================
-- For SQL Server (not PostgreSQL):
-- BULK INSERT customer_table
-- FROM 'C:\tmp\copy.csv'
-- WITH (
--     FORMAT = 'CSV',
--     FIRSTROW = 2,  -- Skip first row (headers)
--     FIELDTERMINATOR = ',',
--     ROWTERMINATOR = '\n'
-- );

-- EXPLANATION (SQL Server syntax):
-- - BULK INSERT: SQL Server command
-- - FROM: File path
-- - FIRSTROW = 2: Skip first 1 row (header)
-- - FIELDTERMINATOR: Column separator
-- - ROWTERMINATOR: Row separator


-- ============================================================
-- METHOD 6: SQL SERVER - OPENROWSET
-- ============================================================
-- For SQL Server (not PostgreSQL):
-- SELECT * INTO customer_table
-- FROM OPENROWSET(BULK 'C:\tmp\copy.csv', FORMAT = 'CSV') AS FileData;

-- EXPLANATION (SQL Server):
-- - OPENROWSET: Read from external source
-- - BULK: Bulk read mode
-- - Loads file into temporary dataset
-- - SELECT * INTO: Creates new table or loads into existing


-- ============================================================
-- METHOD 7: MYSQL - LOAD DATA INFILE
-- ============================================================
-- For MySQL (not PostgreSQL):
-- LOAD DATA INFILE '/tmp/copy.csv'
-- INTO TABLE customer_table
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;  -- Skip header

-- EXPLANATION (MySQL syntax):
-- - LOAD DATA INFILE: MySQL bulk load
-- - INTO TABLE: Target table
-- - FIELDS TERMINATED BY: Column separator
-- - ENCLOSED BY: Quote character
-- - LINES TERMINATED BY: Row separator
-- - IGNORE 1 ROWS: Skip header row


-- ============================================================
-- COMMON OPTIONS AND PARAMETERS
-- ============================================================

-- HEADER:
-- HEADER true : First row contains column names (skip it)
-- HEADER false : All rows are data (no header)
-- Default: false

-- QUOTE:
-- QUOTE '"' : Use double quote as quote character
-- QUOTE OFF : No quote character
-- Default: '"'

-- ESCAPE:
-- ESCAPE '\' : Use backslash to escape special chars
-- ESCAPE OFF : No escape character
-- Default: depends on format

-- NULL HANDLING:
-- NULL '\\N' : Treat \\N as NULL value
-- Specify what string represents NULL

-- ENCODING:
-- ENCODING 'UTF8' : File encoding format
-- ENCODING 'LATIN1' : Alternative encoding
-- Default: depends on database

-- DELIMITER:
-- DELIMITER ',' : Field separator character
-- DELIMITER '|' : Pipe separator
-- DELIMITER '\t' : Tab separator


-- ============================================================
-- DATA TYPE MATCHING
-- ============================================================

-- CRITICAL: Column data types must match file data

-- Table Column: INT
-- File Data: "123" (text) → Converted to 123 (int)
-- File Data: "abc" (text) → ERROR! Cannot convert

-- Table Column: VARCHAR(100)
-- File Data: "John Smith" → Imported as is
-- File Data: 123 → Converted to "123" string

-- Table Column: DATE
-- File Data: "2026-05-01" → Converted to DATE
-- File Data: "05/01/2026" → May error (format mismatch)
-- Solution: Ensure consistent date format

-- Table Column: DECIMAL(10,2)
-- File Data: "123.45" → Converted to 123.45
-- File Data: "abc" → ERROR!

-- BEST PRACTICE: Verify data types before import
-- SELECT column_name, data_type FROM information_schema.columns 
-- WHERE table_name = 'customer_table';


-- ============================================================
-- COMPLETE EXAMPLE - STEP BY STEP
-- ============================================================

-- Step 1: Create table (if doesn't exist)
-- CREATE TABLE customer_table (
--     customer_id INT PRIMARY KEY,
--     name VARCHAR(100),
--     age INT,
--     email VARCHAR(100)
-- );

-- Step 2: Prepare CSV file at C:\tmp\copy.csv
-- Content:
-- customer_id,name,age,email
-- 1,John Smith,25,john@email.com
-- 2,Sarah Johnson,30,sarah@email.com
-- 3,Michael Brown,35,michael@email.com

-- Step 3: Run COPY command
-- COPY customer_table
-- FROM 'C:\tmp\copy.csv'
-- WITH (FORMAT csv, HEADER true);

-- Step 4: Verify import
-- SELECT COUNT(*) FROM customer_table;  -- Should return 3
-- SELECT * FROM customer_table;  -- View imported data


-- ============================================================
-- ERROR HANDLING AND TROUBLESHOOTING
-- ============================================================

-- ERROR: File not found
-- Cause: Path incorrect or file doesn't exist
-- Solution: Check file path, use absolute path, verify file exists

-- ERROR: Data type mismatch
-- Example: Trying to import "abc" into INT column
-- Solution: Check data types, clean data before import, or change table column type

-- ERROR: Column count mismatch
-- Cause: File has different number of columns than table
-- Solution: Use column specification: COPY table (col1, col2, col3) FROM ...

-- ERROR: Delimiter not recognized
-- Cause: File uses different delimiter than specified
-- Solution: Check file content, use QUOTE and ESCAPE correctly

-- ERROR: Header mismatch
-- Cause: HEADER true but no header row, or vice versa
-- Solution: Set HEADER true if file has column names, false if all rows are data

-- ERROR: Permission denied
-- Cause: Database user lacks file read permission
-- Solution: Change file permissions, move file to accessible location


-- ============================================================
-- PERFORMANCE CONSIDERATIONS
-- ============================================================

-- 1. COPY is faster than INSERT for bulk loads
--    COPY: ~1,000 rows/ms (very fast)
--    INSERT: ~10-100 rows/ms (slower)

-- 2. Disable constraints temporarily (caution!)
--    ALTER TABLE customer_table DISABLE TRIGGER ALL;
--    COPY customer_table FROM ...;
--    ALTER TABLE customer_table ENABLE TRIGGER ALL;

-- 3. Disable indexes during import
--    ALTER INDEX idx_name ON customer_table DISABLE;
--    COPY customer_table FROM ...;
--    ALTER INDEX idx_name ON customer_table REBUILD;
--    (Much faster for large files)

-- 4. Import in batches for very large files
--    Split file into parts, import separately
--    Example: copy1.csv, copy2.csv, copy3.csv
--    Reduces memory usage, easier error recovery

-- 5. Use staging table
--    Import to temp table first
--    Validate data
--    Move to production table
--    Example: COPY customer_table_staging FROM ...;
--            Then: INSERT INTO customer_table SELECT * FROM customer_table_staging;


-- ============================================================
-- DATA VALIDATION AFTER IMPORT
-- ============================================================

-- Check row count:
-- SELECT COUNT(*) FROM customer_table;

-- Check for NULL values:
-- SELECT * FROM customer_table WHERE email IS NULL;

-- Check for duplicates:
-- SELECT name, COUNT(*) FROM customer_table GROUP BY name HAVING COUNT(*) > 1;

-- Check data types:
-- SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS 
-- WHERE TABLE_NAME = 'customer_table';

-- Check for invalid data:
-- SELECT * FROM customer_table WHERE age < 0 OR age > 150;

-- Sample data:
-- SELECT * FROM customer_table LIMIT 10;


-- ============================================================
-- BEST PRACTICES
-- ============================================================

-- 1. Always backup before import
--    CREATE TABLE customer_table_backup AS SELECT * FROM customer_table;

-- 2. Use staging table
--    Import to temp table, validate, then move to production

-- 3. Handle headers correctly
--    HEADER true if file has column names
--    HEADER false if file has only data

-- 4. Match data types
--    Ensure file data matches table column types
--    Test with small sample first

-- 5. Use correct delimiter
--    Match delimiter to file format
--    Use QUOTE and ESCAPE for special cases

-- 6. Specify columns explicitly
--    Clearer intent, prevents column mapping errors
--    COPY table (col1, col2, col3) FROM ...

-- 7. Log import operations
--    -- Imported 1000 customer records on 2026-05-01
--    COPY customer_table FROM 'C:\tmp\copy.csv' WITH (...);

-- 8. Validate after import
--    SELECT COUNT(*) to verify row count
--    Check for NULL or invalid values
--    Spot-check random rows

-- 9. Test with small file first
--    Create sample CSV with 10 rows
--    Test import before running on full file

-- 10. Document format
--     Include file structure in comments
--     Document delimiter, encoding, quote handling
--     Help future developers understand


-- ============================================================
-- COMPARISON: COPY vs INSERT vs BULK INSERT
-- ============================================================

-- COPY (PostgreSQL):
-- Speed: Very fast (~1000 rows/ms)
-- Syntax: COPY table FROM 'file'
-- Best for: Large bulk imports, CSV files
-- Flexibility: Good support for delimiters, quotes, escape

-- INSERT:
-- Speed: Slower (~10-100 rows/ms)
-- Syntax: INSERT INTO table VALUES (...)
-- Best for: Small imports, complex transformations
-- Flexibility: Full SQL control

-- BULK INSERT (SQL Server):
-- Speed: Very fast (~1000 rows/ms)
-- Syntax: BULK INSERT table FROM 'file'
-- Best for: Large SQL Server imports
-- Flexibility: Good format options

-- RECOMMENDATION:
-- Large file (10,000+ rows): Use COPY/BULK INSERT
-- Small file (<1,000 rows): Use INSERT or COPY
-- Need transformation: Use INSERT or SELECT INTO
-- Performance critical: Use COPY with disabled indexes


