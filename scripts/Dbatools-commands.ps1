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
# Replace TestSQL01 with the actual SQL Server instance you want to test.
Test-DbaConnection -SqlInstance TestSQL01
# The -SqlInstance parameter specifies the SQL Server instance to test.
# This command will check if a connection can be established to the specified SQL Server instance.
# If successful, then the ConnectSuccess property will be true.

# Connect to a SQL Server instance using the Connect-DbaInstance cmdlet
Connect-DbaInstance -SqlInstance TestSQL01
# This command establishes a connection to the specified SQL Server instance.
# If successful, you will be connected to the SQL Server instance, and you can then execute commands or queries.

# Connect to multiple instances passed as an array
Connect-DbaInstance -SqlInstance TestSQL01, TestSQL02, TestSQL03\TestInstance
# Adjust the instance names as needed for your connection.

# Piping instances Names
"TestSQL01", "TestSQL02" | Connect-DbaInstance

# Instances stored in a variable
$instances = "TestSQL01", "TestSQL02" 
Connect-DbaInstance -SqlInstance $instances
# or
$instances | Connect-DbaInstance
# or
$instances = "TestSQL01", "TestSQL02"
foreach ($instanceName in $instances) {
    Connect-DbaInstance -SqlInstance $instanceName
}

# Get instance names from a separate database source and connect
$instances = (Invoke-DbaQuery -SqlInstance teste -Database DBA -Query "SELECT [InstanceName] FROM [dbo].[Instance]").InstanceName
$instances | Connect-DbaInstance
# or
$instances = Invoke-DbaQuery -SqlInstance TestSQL01 -Database DBA -Query "SELECT [InstanceName] FROM [dbo].[Instance]" | Select-Object -ExpandProperty InstanceName
$instances | Connect-DbaInstance
# ExpandProperty InstanceName is used to extract the 'InstanceName' property from the result

# Connect to instance using a non-default port
Connect-DbaInstance -SqlInstance "TestSQL01,57689"
# or
Connect-DbaInstance -SqlInstance "TestSQL01:57689"

# Connect to instances with SQL Server Authentication
# Connect to the SQL Server instance "TestSQL01" using the SQL Server credential "testadm"
# You will be prompted for the password
Connect-DbaInstance -SqlInstance TestSQL01 -SqlCredential testadm


# Save the credential to use SQL Server Authentication with multiple commands
# Get the credential and set it to a variable
$cred = Get-Credential
# Connect to the local machine using the credential
Connect-DbaInstance -SqlInstance TestSQL01 -SqlCredential $cred
