# Automating Log Shipping Setup with dbatools


# Prerequisites: Before executing the command, ensure that the SQL Server Agent service accounts
# on both primary and secondary instances have read/write permissions to the backup (or copy) destination folders.
# This setup is crucial for the SQL Server Agent jobs that control the log shipping schedule.

# Define parameters for log shipping
$params = @{
    SourceSqlInstance = "test01"
    DestinationSqlInstance = "test02"
    Database = "Dba"
    SharedPath = "\\PatheExample\logship"
}

# Invoke log shipping setup
Invoke-DbaDbLogShipping @params


# Challenges in Troubleshooting Log Shipping:
# Log shipping involves multiple components, and identifying the root cause of failures can be complex.
# Solution with dbatools:
# The Get-DbaDbLogShipError cmdlet in dbatools simplifies the process of gathering error information related to log shipping.
# This command helps in quickly identifying issues like access problems or network-related errors.

# Retrieve and display log shipping errors
Get-DbaDbLogShipError -SqlInstance Test01, Test02 |
Select-Object SqlInstance, LogTime, Message



# Cutover to Secondary Replica

# Define parameters for log shipping recovery
$logShipSplat = @{
    SqlInstance = "test02"
    Database    = "Dba"
}

# Perform the cutover to the secondary replica
Invoke-DbaDbLogShipRecovery @logShipSplat
# Invoke-DbaDbLogShipRecovery uses these parameters to make the secondary database (DBA on test02) the new primary.

# Key Benefits:
# Seamless Transition: Automates the process of bringing the secondary database online with minimal manual intervention.
# Data Integrity: Ensures that all transaction logs are applied, maintaining data consistency.
# Flexibility: Useful in various scenarios including disaster recovery and migration.
