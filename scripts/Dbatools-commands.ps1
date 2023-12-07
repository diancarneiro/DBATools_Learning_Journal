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
