#Get specific properties from the SQL Server instance and export them to a CSV file
Get-DbaDatabase -SqlInstance SqlTest01 | Select Name, Size, LastFullBackup | Export-Csv -Path \\path\Databaseinfo.csv -NoTypeInformation

# Read the contents of a file and return a string of objects
Get-Content \\path\DatabaseInfo.csv


