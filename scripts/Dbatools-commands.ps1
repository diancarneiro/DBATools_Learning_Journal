# Finding command names that match "Connection" in the dbatools module
Get-Command *Connection* -Module dbatools

# Finding command descriptions and examples that match "connection" in the dbatools module
Find-DbaCommand -Tag Connection

# Once you’re finished installing, you may find yourself in need of documentation and help.
# PowerShell makes getting help incredibly easy: use Get-Help, as shown in the next listing.

# Example: Get help for a specific cmdlet, for example, Test-DbaConnection
Get-Help Test-DbaConnection

# Example: Get help online for a specific module
Get-Help Test-DbaConnection -Online

# Example: Get detailed help for a specific cmdlet. The parameter section shows the parameters available for this command.
Get-Help Test-DbaConnection -Detailed


# Testing SQL engine and PowerShell remote connectivity

# Use the Test-DbaConnection cmdlet to test SQL Server engine and PowerShell remote connectivity
# Replace $Env:ComputerName with the actual SQL Server instance you want to test.
Test-DbaConnection -SqlInstance $Env:ComputerName

# The -SqlInstance parameter specifies the SQL Server instance to test.
# This command will check if a connection can be established to the specified SQL Server instance.
# If successful, then the ConnectSuccess property will be true.


# Connect to a SQL Server instance using the Connect-DbaInstance cmdlet

Connect-DbaInstance -SqlInstance TestSQLInstance

# This command establishes a connection to the specified SQL Server instance.
# If successful, you will be connected to the SQL Server instance, and you can then execute commands or queries.


