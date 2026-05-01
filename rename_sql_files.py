import os
import shutil

# Change to the SQL_WORKSPACE directory
os.chdir(r"c:\SQL_WORKSPACE")

# Define the file renaming mapping
file_map = {
    "SELECT.SQL": "01_SELECT.sql",
    "where.sql": "02_WHERE.sql",
    "Distinct.sql": "03_DISTINCT.sql",
    "logicaloperator.sql": "04_LOGICALOPERATOR.sql",
    "INSERT.SQL": "05_INSERT.sql",
    "UPDATE.SQL": "06_UPDATE.sql",
    "delete.sql": "07_DELETE.sql",
    "alter.sql": "08_ALTER.sql",
    "ImportDataFromFile.sql": "09_IMPORTDATAFROMFILE.sql",
    "EXERCISE3.SQL": "10_EXERCISE3.sql",
    "Exercise4.sql": "11_EXERCISE4.sql",
}

print("Renaming SQL files in learning order...\n")

for old_name, new_name in file_map.items():
    old_path = os.path.join(os.getcwd(), old_name)
    new_path = os.path.join(os.getcwd(), new_name)
    
    if os.path.exists(old_path):
        os.rename(old_path, new_path)
        print(f"✓ {old_name} → {new_name}")
    else:
        print(f"✗ {old_name} not found")

print("\nFinal organized structure:")
print("-" * 40)

# List all .sql files sorted
sql_files = sorted([f for f in os.listdir(".") if f.endswith(".sql")])
for i, filename in enumerate(sql_files, 1):
    print(f"  {filename}")

print("-" * 40)
print(f"\nTotal SQL files: {len(sql_files)}")
