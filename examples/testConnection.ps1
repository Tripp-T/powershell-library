$hostFQDN = "localhost"
# Notes:
# `-InformationLevel Quiet` will only return a boolean value

# Test ICMP
Test-NetConnection -ComputerName $hostFQDN -TraceRoute
# Test port (Ex. MSTSC)
Test-NetConnection -ComputerName $hostFQDN -Port 3389 -Verbose 
