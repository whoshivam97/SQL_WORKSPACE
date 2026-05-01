@echo off
cd /d "c:\SQL_WORKSPACE"

echo Renaming SQL files in learning order...
echo.

ren "SELECT.SQL" "01_SELECT.sql"
echo Renamed SELECT.SQL to 01_SELECT.sql

ren "where.sql" "02_WHERE.sql"
echo Renamed where.sql to 02_WHERE.sql

ren "Distinct.sql" "03_DISTINCT.sql"
echo Renamed Distinct.sql to 03_DISTINCT.sql

ren "logicaloperator.sql" "04_LOGICALOPERATOR.sql"
echo Renamed logicaloperator.sql to 04_LOGICALOPERATOR.sql

ren "INSERT.SQL" "05_INSERT.sql"
echo Renamed INSERT.SQL to 05_INSERT.sql

ren "UPDATE.SQL" "06_UPDATE.sql"
echo Renamed UPDATE.SQL to 06_UPDATE.sql

ren "delete.sql" "07_DELETE.sql"
echo Renamed delete.sql to 07_DELETE.sql

ren "alter.sql" "08_ALTER.sql"
echo Renamed alter.sql to 08_ALTER.sql

ren "ImportDataFromFile.sql" "09_IMPORTDATAFROMFILE.sql"
echo Renamed ImportDataFromFile.sql to 09_IMPORTDATAFROMFILE.sql

ren "EXERCISE3.SQL" "10_EXERCISE3.sql"
echo Renamed EXERCISE3.SQL to 10_EXERCISE3.sql

ren "Exercise4.sql" "11_EXERCISE4.sql"
echo Renamed Exercise4.sql to 11_EXERCISE4.sql

echo.
echo All files renamed successfully!
echo.
echo Final organized structure:
dir /b *.sql
pause
