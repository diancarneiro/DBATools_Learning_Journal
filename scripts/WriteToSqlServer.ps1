# Replace 'TestSQL01' with your SQL Server instance name and 'DBA' with your database name as needed.

# Get specific properties from the SQL Server instance and export them to a CSV file
# Use Select to display only the properties that you want to see. 
Get-DbaDatabase -SqlInstance TestSQL01 | Select Name, Size, LastFullBackup | Export-Csv -Path \\path\Databaseinfo.csv -NoTypeInformation
# The -NoTypeInformation parameter removes the #Type information header from csv file output.

Get-DbaErrorLog

# Read the contents of a file and return a string of objects
Get-Content \\path\DatabaseInfo.csv

# Import the CSV and write to the database
Import-Csv -Path .\Databaseinfo.csv | Write-DbaDataTable -SqlInstance TestSQL01 -Database DBA -Table Databases -AutoCreateTable

# Read/Select from a database table
# This script segment uses Invoke-DbaQuery to execute a SQL query on a specified SQL Server instance and database.
# The query is stored in the $query variable and is set to select all records from the 'Databases' table.
$query = "SELECT * FROM Databases" 
Invoke-DbaQuery -SqlInstance TestSQL01 -Database DBA -Query $query

# The Get-DbaDbTable command is used to retrieve information about tables in a specified database on a SQL Server instance.
# This command is useful for getting details such as table names, schemas, row counts, and space usage among others.
# Example usage:
# This will get a list of all tables from the 'DBA' database on the 'TestSQL01' SQL Server instance.
$tables = Get-DbaDbTable -SqlInstance TestSQL01 -Database DBA
# This will get a list of all data types of the columns the 'DBA' database on the 'TestSQL01' SQL Server instance in databases table.
(Get-DbaDbTable -SqlInstance TestSQL01 -Database DBA -Table Databases).Columns | Select-Object Parent, Name, Datatype
(Get-DbaDbTable -SqlInstance devloosql05-t -Database DBA -Table Instance).Columns | Select-Object -ExpandProperty DataType

