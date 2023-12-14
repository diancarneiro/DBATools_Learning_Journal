# Find-DbaInstance
# The Find-DbaInstance command from dbatools is used for discovering SQL Server instances across a network. 


# Usage Advisory:
# - Find-DbaInstance is best for finding undocumented or rogue SQL Server instances.
# - It's not recommended for daily inventory due to its deep and time-consuming scans.
# - For regular inventory, consider using lighter methods like SQL Server's Registered Servers.

# Appropriate Use:
# - Use Find-DbaInstance for occasional, in-depth network scans to detect unexpected instances.

# It consists of two main phases: Discovery and Scan.
# Discovery Phase:
# - Identifies the computers within the network that will be scanned for SQL Server instances.
# - Can utilize methods like Active Directory checks, IP range scanning, or specific computer names.

# Scan Phase:
# - Actively probes the discovered computers to identify running SQL Server instances.
# - Detects SQL Server services and components to provide detailed instance information.

# Example Usage:
Find-DbaInstance -ComputerName 'Server1'
# Or
Find-DbaInstance -ComputerName 'Server1' -ScanType Browser
# This command performs a series of steps to discover SQL Server instances:

    # 1. Resolves the specified computer name in DNS to ensure it's reachable.
    # 2. Pings the computer to check network connectivity.
    # 3. Uses CIM/WMI to identify all SQL Server Services running on the computer.
    # 4. Discovers all SQL instances using UDP and the SQL Server Browser service.
    # 5. Attempts to connect to the default SQL Server TCP port (1433).
    # 6. Connects to the TCP port of each detected SQL Server instance.
    # 7. Retrieves the Service Principal Names (SPNs) for each SQL instance.

# These steps collectively help in accurately identifying and locating SQL Server instances in the network.


# Benefits:
# - Automates and simplifies the process of locating SQL Server instances in a network.
# - Essential for database inventory management, audits, and maintenance activities.



# Specify just one IP
Find-DbaInstance -DiscoveryType IPRange -IpAddress 100.10.10.10
# Specify a range
PS> Find-DbaInstance -DiscoveryType IPRange -IpAddress 100.10.10.10/24
#  This option can take hours, particularly when numerous systems are offline or have unresolvable addresses, can still be a time-consuming process, potentially taking hours to complete.
