# Logins and Users

# Step 1: Check SQL Error Log for Login Failures
# Use Get-DbaErrorLog to review the SQL error logs and identify any login failure events.
Get-DbaErrorLog -SqlInstance TEST01 -After (Get-Date).AddMinutes(-5) | Format-Table
#or 

$connGetErrorLog = @{

    SqlInstance="TEST01"
    After=(Get-Date).AddMinutes(-5)
}
Get-DbaErrorLog @connGetErrorLog | Select LogDate, Source, Text | Format-Table


# Step 2: Verify Existing Logins and Users
# Utilize Get-DbaLogin to check for existing logins on the SQL Server instance.
Get-DbaLogin -SqlInstance TEST01

# Next, use Get-DbaDbUser to check for users in the specific database.
Get-DbaDbUser -SqlInstance TEST01 -Database DBA

# Step 3: Create New Login if User Does Not Exist
# If the user is not found in the logins, create a new login using New-DbaLogin.
New-DbaLogin -SqlInstance TEST01 -Login YourNewLogin 

# Step 4: Check for Orphaned Users
# In case the application still fails, check for orphaned users in the database.
Get-DbaDbOrphanUser -SqlInstance TEST01 -Database DBA

# Step 5: Repair Orphaned Users
# If orphaned users are found, repair them using Repair-DbaDbOrphanUser.
Repair-DbaDbOrphanUser -SqlInstance TEST01 -Database DBA
# Before running the repair function, ensure the corresponding SQL Server login exists.
# If you run Repair-DbaDbOrphanUser without a corresponding server-level login, 
# it will result in 'No matching login' status.
# After ensuring the login exists, run the Repair-DbaDbOrphanUser function to fix any orphaned users.


# 2. Preventing Login Issues


# Syncing users across an availability group
    Get-Help Copy-DbaLogin -Full

# 3.Logins, users, and permissions source control

Export-DbaLogin -SqlInstance devloosql01-t -Path \\folder\dbatoolsexport

# Utilize Git for version control. Automate daily download of the exported login file.
# This enables the comparison of login details between different days to track any changes.
# Schedule a task to download and commit the file to a Git repository daily for effective tracking.

# Listing the permissions on the instance
Get-DbaUserPermission -SqlInstance devloosql01-t -Database DBA |
Select SqlInstance, Object, Type, Member, RoleSecurableClass | Format-Table

# Download the list to Excel file
# Install-Module -Name ImportExcel -Scope CurrentUser

Get-Help Export-Excel -Detailed

