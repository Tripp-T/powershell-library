# Set a PowerShell session environment (env) variable. Note that the syntax is the same to overwrite an existing env variable.
$env:CustomEnvVar = Get-Date

# Set a persistent env variable using .NET syntax.
[System.Environment]::SetEnvironmentVariable('CustomEnvVarName','CustomEnvValue')

# Show only one env variable. (Allows for string operators without pipes.)
$env:PSModulePath -split ';'

# Show all env variables. Note that "Env:" is a path that can also be used with a legacy command like dir.
Get-ChildItem -Path Env: