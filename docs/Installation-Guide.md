# Installation Guide for dbatools

## Prerequisites

- [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell)
- [SQL Server Management Studio (SSMS)](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)

## Installation Steps

### 1. Install PowerShellGet (if not already installed)

[How to Install PowerShellGet](https://learn.microsoft.com/en-us/powershell/gallery/powershellget/install-powershellget?view=powershellget-3.x&viewFallbackFrom=powershell-7.1)

```powershell
Install-Module -Name PowerShellGet -Force -AllowClobber
```

### 2. Execution Policy (safety mechanism)

```powershell
# Set the script execution policy to RemoteSigned for the current user
# This allows locally created scripts to run without a digital signature,
# but requires a signature for scripts downloaded from the internet.


Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 3. Trusting the PowerShell Gallery
I trust Microsoft’s PowerShell Gallery

```powershell
# Set the installation policy of the PSGallery repository to Trusted
# This allows scripts from the PowerShell Gallery to be installed without user confirmation.

Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
```

### 4. Install dbatools from the PowerShell Gallery for all users


```powershell
# Step 1: Open a PowerShell session as an Administrator
# Note: Right-click on the PowerShell icon and choose "Run as Administrator"
#       to ensure you have the necessary permissions to install modules for all users.
 
# Step 2: Set the Execution Policy (if needed)
# Note: Setting the execution policy to RemoteSigned allows script execution.
#       This step may already be done if the policy is appropriately configured.
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force

# Step 3: Install dbatools for all users
# Note: The -Scope parameter is set to AllUsers to make the module available
#       to all users on the machine.
#       The -Force parameter installs the module without asking for confirmation.
#       The -AllowClobber parameter allows overwriting existing commands with the same name.
Install-Module -Name dbatools -Scope AllUsers -Force -AllowClobber

# Step 4: Import the dbatools module (if not auto-imported)
# Note: By default, modules are auto-imported for the current user.
#       If dbatools is not auto-imported, you can manually import it using this command.
Import-Module dbatools

# Setp 5: View the list of certificates to verify the installation
# Run one of the following commands:
# Note: This step is optional and helps verify the installation for the current user.
Get-ChildItem Cert:\CurrentUser\TrustedPublisher | Select-Object *
# or
# Note: Run certmgr to view the certificates in the Trusted Publisher store interactively
certmgr

```

## Update dbatools

# Update dbatools from the PowerShell Gallery

```powershell
Update-Module dbatools
```


