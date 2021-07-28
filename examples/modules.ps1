# Get all installed PowerShell modules.
Get-InstalledModule

# Query if a specific PowerShell module is installed. Additional parameters such as -RequiredVersion may also be specified.
Get-InstalledModule -Name "ModuleName"

# Install a PowerShell module. (**Requires Administrative Permissions**)
Install-Module -Name "ModuleName"