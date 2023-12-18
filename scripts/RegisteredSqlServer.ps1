
# Purpose: The primary purpose of Get-DbaRegServer is to fetch details of all the registered SQL Server instances. 
# This can include servers registered in SSMS's Local Server Groups, Central Management Server (CMS), or servers registered directly within dbatools.

Get-DbaRegServer
# Functionality:
# Retrieves information such as server names, groups, and connection details.
# Can access servers registered in various groups and subgroups.
# Useful for scripting and automating tasks across multiple servers.

# Parameters: -SqlInstance -Group -Credential

## We appreciate the flexibility of Local Server Groups as they enable us to securely store connection credentials. 
## However, a limitation is that we cannot share the inventory list with other database administrators, which can be a drawback in collaborative environments.
## Credential passwords are encrypted and stored within RegSrvr.xml.
## All data in Local Server Groups is stored locally on your hard drive in a file called RegSrvr.xml, deep in the $home\AppData\Roaming\Microsoft\ directory. 


Get-Help Get-DbaRegServer -Detailed

Get-DbaRegServer -Group Main\DEV\CLUSTER_01\Node_01

Get-DbaRegServer -Group Main\DEV\CLUSTER_01\Node_01 | Get-DbaDatabase | Out-GridView -Passthru | Select *

