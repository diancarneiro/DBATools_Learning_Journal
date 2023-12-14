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
(Get-DbaDbTable -SqlInstance TestSQL01 -Database DBA -Table Databases).Columns | Select-Object -ExpandProperty DataType


# Remove a table from a SQL Server database
# The Remove-DbaDbTable command is used to drop a specified table from a given database on a SQL Server instance.
# Caution: This action is irreversible and should be used with care.
Remove-DbaDbTable -SqlInstance TestSQL01 -Database DBA -Table databases


# Get the Database information and write to the database
# This script segment performs two main functions using dbatools:
# 1. Retrieves information about user databases from a SQL Server instance ('TestSQL01') using Get-DbaDatabase.
#    - The -ExcludeSystem parameter excludes system databases from the results.
#    - The information retrieved includes the database Name, Size, and the date of the Last Full Backup.
# 2. Writes the retrieved data to a table in another database using Write-DbaDataTable.
#    - The data is written to the 'Databases' table in the 'DBA' database on the 'TestSQL01' instance.
#    - If the 'Databases' table does not exist, the -AutoCreateTable parameter allows the command to create it automatically.

# Example usage:
Get-DbaDatabase -SqlInstance TestSQL01 -ExcludeSystem | Select-Object Name, Size, LastFullBackup | Write-DbaDataTable -SqlInstance TestSQL01 -Database DBA -Table Databases -AutoCreateTable


# Use Get-Member to Examine Object Data Types
# Get-Member is used to display the properties and methods of objects produced by PowerShell commands.
# This is particularly useful for understanding the structure and data types of objects returned by commands like Import-Csv and Get-DbaDatabase.
# By applying Get-Member to the outputs of these commands, you can see why tables created by these commands 
# might have different data types, as the cmdlets may interpret and present the data differently.
# Example Usage:
# To see the properties and data types of objects returned by Get-DbaDatabase, you can pipe its output to Get-Member:
Get-DbaDatabase -SqlInstance TestSQL01 | Get-Member
# Similarly, for objects imported via Import-Csv:
Import-Csv -Path "\\path\DatabaseInfo.csv" | Get-Member
# These commands will list the properties, including names and data types, and methods for the objects outputted by Get-DbaDatabase and Import-Csv.


# PowerShell Snippet for Identifying Maximum Data Length in Each Column of a DataTable
# This script is useful when facing SQL errors related to data type or length mismatches, such as the SQL error 8152 or 2628.
# These errors occur when the length of the data being inserted into a column exceeds the column's defined width.
# The script iterates through each column of a provided data table and determines the maximum length of data in that column.
# This is especially helpful in identifying which column(s) might be causing data insertion failures, particularly with large datasets.
# How it works:
# 1. It retrieves all column names from the datatable using Get-Member.
# 2. It iterates through each column and each row, checking the length of the data in each cell.
# 3. It keeps track of the maximum length found for each column.
# 4. The maximum lengths are then outputted, helping to identify if any column's data exceeds the expected or defined length.

# Example usage:
$datatable = Import-Csv -Path .\Databaseinfo.csv | ConvertTo-DbaDataTable
$columns = ($datatable | Get-Member -MemberType Property).Name
foreach($column in $columns) {
    $max = 0
    foreach ($row in $datatable){
        if($max -lt $row.$column.Length){
            $max = $row.$column.Length
        }
    }
    Write-Output "$column max length is $max"
}
