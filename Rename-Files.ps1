
# SQL File Renaming Script
# Changes to the SQL_WORKSPACE directory and renames files in learning order

Set-Location "c:\SQL_WORKSPACE"

$fileMap = @{
    "SELECT.SQL" = "01_SELECT.sql"
    "where.sql" = "02_WHERE.sql"
    "Distinct.sql" = "03_DISTINCT.sql"
    "logicaloperator.sql" = "04_LOGICALOPERATOR.sql"
    "INSERT.SQL" = "05_INSERT.sql"
    "UPDATE.SQL" = "06_UPDATE.sql"
    "delete.sql" = "07_DELETE.sql"
    "alter.sql" = "08_ALTER.sql"
    "ImportDataFromFile.sql" = "09_IMPORTDATAFROMFILE.sql"
    "EXERCISE3.SQL" = "10_EXERCISE3.sql"
    "Exercise4.sql" = "11_EXERCISE4.sql"
}

Write-Host "Renaming SQL files in learning order..." -ForegroundColor Green
Write-Host ""

foreach ($oldName in $fileMap.Keys) {
    $newName = $fileMap[$oldName]
    $oldPath = Join-Path (Get-Location) $oldName
    
    if (Test-Path $oldPath) {
        Rename-Item -Path $oldPath -NewName $newName -Force
        Write-Host "✓ $oldName → $newName"
    } else {
        Write-Host "✗ $oldName not found" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Final organized structure:" -ForegroundColor Green
Get-ChildItem -Filter "*.sql" | Sort-Object Name | Select-Object Name | Format-Table -AutoSize
