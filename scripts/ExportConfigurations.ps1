# Exporting an Entire SQL Server Instance with dbatools

# The Export-DbaInstance command from dbatools is a holistic solution for exporting virtually all aspects of a SQL Server instance. This includes, but is not limited to:

# Databases: The actual database files and their restore scripts.
# Logins: Including hashed passwords, roles, and permissions.
# Linked Servers: With configurations like server type and remote user.
# Credentials: Including identities and passwords.
# Database Mail: Covering profiles, accounts, and settings.
# SQL Server Agent Jobs: Along with their schedules, categories, and operators.
# Proxies: Including the associated credentials and subsystems.
# Alerts: Covering database alerts, error numbers, severity levels.
# Replication Settings: Information about publishers and subscribers.
# Server Configurations: Settings from sp_configure.
# Custom Errors: Custom error messages and language settings.
# Server Roles: Information about owner and securables.
# Central Management Server: Details including description and authentication.
# Backup Devices: Backup destination information.
# Audits: Audit properties and specifications.
# Endpoints: Including protocols, types, ports.
# Policy-Based Management: Policies, categories, and conditions.
# Resource Governor: Resource pools and classifier functions.
# Extended Events: Configuration of properties, events, and storage.
# User Objects in System Databases: Custom scripts, maintenance solutions.
# Availability Groups: Details on databases and replicas.

Export-DbaInstance -SqlInstance test01 -Path \\Path\example\DBA 
# -Exclude = "ResourceGovernor"
