-- ============================================================
-- EXERCISE 4: UPDATE, DELETE, and ALTER TABLE Operations
-- ============================================================

-- 1. UPDATE OPERATION
-- ============================================================
UPDATE science_classroom 
SET science_marks = 45 
WHERE name = 'Sam';

-- EXPLANATION:
-- - Updates the science_marks column for a specific student
-- - Sets science_marks to 45 for the student named 'Sam'
-- - WHERE clause specifies which record(s) to update
-- - Only records matching the condition are modified
-- - If WHERE clause omitted, ALL records would be updated (dangerous!)


-- 2. DELETE OPERATION
-- ============================================================
DELETE FROM science_classroom 
WHERE name = 'Jon';

-- EXPLANATION:
-- - Deletes entire record(s) from the science_classroom table
-- - Removes the student named 'Jon' completelyy
-- - WHERE clause specifies which record(s) to delete
-- - If WHERE clause omitted, ALL records would jbe deleted (very dangerous!)
-- - Always use WHERE clause to specify target records


-- 3. ALTER TABLE OPERATION - RENAME COLUMN
-- ============================================================
ALTER TABLE science_classroom 
RENAME COLUMN name TO student_name;

-- EXPLANATION:
-- - Modifies the table structure by renaming a column
-- - Changes column name from 'name' to 'student_name'
-- - Does NOT affect data, only the column name
-- - All references to this column in queries must use new name
-- - Use this when column names need to be more descriptive

-- NOTE: Syntax varies by SQL dialect:
-- SQL Server: sp_rename 'science_classroom.name', 'student_name'
-- MySQL: ALTER TABLE science_classroom CHANGE name student_name VARCHAR(100)
-- PostgreSQL: ALTER TABLE science_classroom RENAME COLUMN name TO student_name