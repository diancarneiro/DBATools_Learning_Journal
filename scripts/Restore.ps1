
# Restore from a file
Restore-DbaDatabase -SqlInstance TEST01 -Path -Path \\Path\Example\sqlbackps\test.bak
# or 
Get-ChildItem \\Path\Example\sqlbackps\test.bak | Restore-DbaDatabase -SqlInstance TEST01
# Note:
# The path to the backup file is relative to the SQL Server instance and not your own computer.


# Renaming a Database and Its Physical Files During Restore
# While using the -DatabaseName parameter in Restore-DbaDatabase command changes the database's name,
# it does not rename the underlying physical files (MDF, NDF, LDF). This is akin to renaming a database
# in SSMS through the UI, which does not affect the file names on the disk.

# To rename the physical database files during the restore process, use the -ReplaceDbNameInFile parameter.
# This ensures that both the logical database name and the physical filenames are updated.
# Example:
Restore-DbaDatabase -SqlInstance YourInstance -Path "\\Path\To\Backup.bak" -DatabaseName "NewDbName" -ReplaceDbNameInFile


# Recovering a Corrupt Database by Restoring Corrupt Pages

# One effective method for dealing with database corruption is to restore corrupt pages from a backup.
# Often, database corruption is attributed to hardware issues, such as problems with the storage system.
# Restoring only the corrupt pages, instead of the entire database, can be a significant time-saver,
# especially for large databases where the corruption affects only a small part.

# The process begins with identifying pages that are marked as suspect (potentially corrupt). 
# This is done using the Get-DbaSuspectPage cmdlet, which scans the database for such pages.

# Microsoft provides detailed documentation on page restores, including their limitations and restrictions,
# which can be found at: sqlps.io/restorepages

# Example:
# Setp 1: Identify suspect pages in a database
$corruption = Get-DbaSuspectPage -SqlInstance TEST01 -Database DBA

# Step 2: Define Restore Parameters using Splatting
# PowerShell splatting is used here for readability. It's a method of bundling parameters in a hashtable to pass to a cmdlet.
$splatRestoreDbPage = @{
    SqlInstance = "YourInstance"                     # SQL Server instance name
    Path = "\\example\dba.bak"       # Path to the backup file
    PageRestore = $corruption                 # The corrupt pages identified earlier
    PageRestoreTailFolder = "c:\temp"         # Folder for tail-log backup, if needed
}

# Step 3: Restore the Corrupt Pages
# Restore-DbaDatabase is used with the splatting parameters to restore just the corrupt pages.
Restore-DbaDatabase @splatRestoreDbPage

