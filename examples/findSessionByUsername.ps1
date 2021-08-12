# Username to query a session for
$username = "user"
# Store results of query CMD
$sessionQuery = query session $username
# If we got a result there should be a session
if ($null -ne $sessionQuery) {
    Write-Host $sessionQuery
    # Skip first line of results and select ID 
    $sessionID = ($sessionQuery | Select-Object -skip 1).substring(45,2)
    # Work with the sessionID (logoff, etc..)
    Write-Host ` $username has session $sessionID`
} 