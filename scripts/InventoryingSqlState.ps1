Get-Help Get-DbaFeature -Detailed
Get-Help Get-DbaBuildReference -Detailed
Get-Help Test-DbaBuild -Detailed
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
