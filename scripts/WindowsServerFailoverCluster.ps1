 Get-Command *wsfc* -Module dbatools

 # Windows Server Failover Cluster (WSFC) and dbatools Integration

# Overview of WSFC:
# Purpose: WSFC is a feature that enhances the high availability of SQL Server instances.
# Applications: It forms the foundation for implementing Failover Cluster Instances (FCI) and Always On Availability Groups (AG), both crucial for maintaining SQL Server uptime and data availability.

Get-DbaWsfcNode -ComputerName test01
# Viewing the resource details for our WSFC
Get-DbaWsfcResource -ComputerName test01 |Select-Object ClusterName, Name, State, Type, OwnerGroup, OwnerNode | Format-Table

# dbatools for AG Setup: Utilize dbatools commands to automate the creation and configuration of AGs, aligning with the specific needs of your SQL Server environment.

# Getting general information about availability groups
Get-DbaAvailabilityGroup -SqlInstance test01
# Getting information about the availability group replicas
Get-DbaAgReplica -SqlInstance test01 | Select-Object SqlInstance, AvailabilityGroup, Name, Role, AvailabilityMode, FailoverMode


# Simplifying Failovers with dbatools
# Condition-Based Failover: Using dbatools, you can perform failovers that ensure data synchronization and no data loss, ideal for scenarios with high data integrity requirements.
# Failover the AG to a secondary replica with no data loss
Invoke-DbaAgFailover -SqlInstance $sql -AvailabilityGroup test_01
# $sql represents the SQL Server instance where the failover is targeted.

# Handling Disaster Scenarios:
# Forced Failover: In critical situations, such as losing the primary replica or in disaster recovery scenarios where some data loss is acceptable, 
# the -Force parameter can be used to invoke an immediate failover.
Invoke-DbaAgFailover -SqlInstance $sql -AvailabilityGroup test_01 -Force



# Suspending Data Movement:
# Purpose: The Suspend-DbaAgDbDataMovement command is used to pause data synchronization in an AG. This is particularly useful during patching, maintenance, or when taking a replica offline.
# Transaction Log Consideration: It's important to note that suspending data movement will cause the transaction log on the primary database to grow. This happens because transactions that haven't been replicated to the secondary are queued up until data movement resumes.
# Example: Suspending Data Synchronization

# Suspend data movement to the secondary replica
# To suspend data movement to a secondary replica, use the following command:
Suspend-DbaAgDbDataMovement -SqlInstance $sql -AvailabilityGroup test_01
# $sql represents the SQL Server instance of the primary replica.

# Resuming Data Movement:
# After completing the necessary maintenance or patching tasks, data movement can be resumed to ensure the AG is back in synchronization:
# Resume data movement to the secondary replica
Resume-DbaAgDbDataMovement -SqlInstance $sql1 -AvailabilityGroup ACME_01

# Key Points:
# Monitoring: Keep an eye on the transaction log size on the primary during the suspension period.
# Planning: Ensure that suspension and resumption of data movement are part of a planned and controlled process to maintain the health and integrity of your AGs.

