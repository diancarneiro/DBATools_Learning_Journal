Get-Help Get-DbaFeature -Detailed
Get-Help Get-DbaBuildReference -Detailed
Get-Help Test-DbaBuild -Detailed

# SQL FEATURES

# Get-DbaFeature command is used to identify the installed SQL Server features on a given instance or set of instances. 
# It's a handy tool for administrators who need to quickly audit the features enabled on their SQL Servers.
Get-DbaFeature -ComputerName HostServerName | Format-Table
# Functionality: 
# This command scans SQL Server instances and returns information about the features that are installed. 
# This can include the database engine, Analysis Services, Reporting Services, Integration Services, and other features.

# Get-DbaBuildReference command is used to get the build reference information for SQL Server instances. 
# It's essential for checking the version and build information against a known list of SQL Server builds.
Get-DbaBuildReference -SqlInstance TestSQL01 -Update | Format-Table
#Functionality: 
# This command consults an internal or externally updated database of SQL Server builds, providing details like the version, build number, support dates, and more. 
# It's useful for quickly determining if your SQL Server instances are up-to-date, or if they're running a version that's no longer supported.


# Troubleshooting
# If you get the following error: WARNING: [11:24:09][Get-DbaBuildReferenceIndex] Index is stale, last update on: 2023-10-13T00:00:00, try the -Update parameter to fetch the most up to date index
# Run the following command:
Get-DbaBuildReference -Update

# Check Build Compliance
# Test-DbaBuild is used to compare the current build of a SQL Server instance against the most recent known builds.
# It helps in identifying if the SQL Server instance is up-to-date, if it's running a version that's out of support, or if it has pending service packs or cumulative updates.
Test-DbaBuild -SqlInstance TestSQL01 -Latest
# -Latest: This parameter modifies the command to specifically check if the instance is running the latest available build. It's a quick way to ensure that your SQL Server is up-to-date with the most recent updates and patches.
# Functionality: 
# When you run Test-DbaBuild, it checks the version of your SQL Server instance against a comprehensive list of known builds, including service packs and cumulative updates. 
# The command will inform you if your current build is outdated and will suggest the latest available build or the next build you should update to.



# HOST INFORMATION
# Get-DbaComputerSystem and Get-DbaOperatingSystem, are crucial for a comprehensive understanding of the environment in which SQL Server is running.

# Get-DbaComputerSystem command is used to retrieve detailed information about the computer system on which your SQL Server instance is running. 
# This includes hardware-level details like CPU, memory, and manufacturer information.
Get-DbaComputerSystem -SqlInstance TestSQL01
# Functionality: 
# It collects data about the server's physical and virtual memory, processor (CPU) information, system architecture, and other relevant hardware details. 
# This can be particularly helpful for capacity planning, performance tuning, ensuring that the SQL Server environment meets the necessary hardware specifications and if it needs to be rebooted or not.


# Get-DbaOperatingSystem command is designed to provide information about the operating system on which a SQL Server instance is running.
Get-DbaOperatingSystem  -SqlInstance TestSQL01
# Functionality: 
# This command gives details like the OS version, service pack level, OS architecture (32-bit or 64-bit), and other system settings. 
# It's valuable for understanding the environment in which SQL Server is operating, especially when considering compatibility and supportability.


# DATABASES

# Get-DbaDatabase is used to gather details about one or more databases residing on a specified SQL Server instance. 
# It can provide a wide range of information including the database name, size, status, recovery model, and other critical properties.
Get-DbaDatabase -SqlInstance TestSQL01
# Functionality:
# This command can be used to obtain detailed information about databases, such as their names, sizes, status (online, offline, restoring, etc.), 
# recovery models, compatibility levels, and file information (like data and log file sizes and locations).

# Get all databases without a full backup
Get-DbaDatabase -SqlInstance TestSQL01 -NoFullBackup

# Get all databases without a full backup in the last 30 days
$date = (Get-Date).AddDays(-30)
Get-DbaDatabase -SqlInstance TestSQL01 -NoFullBackupSince $date
