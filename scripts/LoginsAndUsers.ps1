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
