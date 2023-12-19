# Backup Types
# Ola Hallengren’s Maintenance Solution: https://ola.hallengren.com/

Install-DbaMaintenanceSolution -SqlInstance TES01 -InstallJobs -ReplaceExisting 

# Backing Up an Entire SQL Server Instance
# The following command performs full backups of all databases on the SQL Server instance TEST01.
# It saves the backups to the instance's default backup directory.
Backup-DbaDatabase -SqlInstance TEST01
# Note:
# - This command will backup every database on TEST01.
# - Since a specific backup file name is not provided, dbatools will automatically generate 
#   filenames for each backup file. The naming convention includes the database name along with 
#   the current date and time, ensuring each backup file is uniquely identified.
# - The SQL Server service account must have write permissions to the backup path


# Generating Backup Scripts for Databases Containing "dba"
$bigdbs = Get-DbaDatabase -SqlInstance TEST01 | Where Name -match dba
$bigdbs | Backup-DbaDatabase -Path \\Path\Example\sqlbackps -OutputScriptOnly
# The scripts will be configured to perform backups of these specific databases.

# Reading backup files
Get-Command -Module dbatools -Name *backup*
Read-DbaBackupHeader -SqlInstance TEST01 -Path \\Path\Example\sqlbackps\test.bak

# Getting database backup history
Get-DbaDbBackupHistory -SqlInstance TEST01 -Database dba
# Note: 
# -Last parameter to gather the last full, diff and log bakp

# Finding and removing old backup file
 Find-DbaBackup -Path \\Path\Example\sqlbackps -BackupFileExtension bak -RetentionPeriod 90d | Remove-Item -Verbose

#DBATOOLS SUPPORTS ONLY NATIVE SQL SERVER BACKUP


# Overview of Test-DbaLastBackup Process
# https://dbatools.io/dedicated-server/
# 1. Connect to SQL Server:
#    The routine begins by logging into a specified SQL Server instance and compiling a list of all its databases.

# 2. Gather Backup Information:
#    For each database, it retrieves details of the most recent full, differential, and log backups.

# 3. Restore Backup Chain:
#    The complete chain of backups (full, diff, and log) is then restored to a destination server. This can be either the same server (local) or a different one (remote).
#    - Note: The restored databases are given new names and file paths to avoid conflicts with existing databases.

# 4. Integrity Check:
#    After restoration, a DBCC CHECKDB is performed on each restored database to ensure integrity and consistency.

# 5. Cleanup and Reporting:
#    The test databases are subsequently dropped.
#    - The routine concludes by reporting the success or failure of these operations, providing insights into the reliability of the backups.

 
