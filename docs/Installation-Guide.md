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
