# Register a new driver to be used when adding a printer driver
Start-Process -Wait pnputil.exe -a \path\to\driver\oemsetup.inf
# Get existing driver
Get-WindowsDriver -All -Online | Where-Object {$_.OriginalFileName -like '*driver.inf'} | Select-Object -ExpandProperty OriginalFileName -OutVariable infPath


# Add printer driver (If using the get existing driver method, update -InfPath argument to $infPath)
Add-PrinterDriver -Name "Driver Name From inf" -InfPath \path\to\driver\oemsetup.inf
# Get-PrinterDriver can be used to identify if the print driver is already loaded

# Add local printer port
Add-PrinterPort -Name "LocalPortName:"
# Add TCP printer port
Add-PrinterPort -Name "TCPPortName:" -PrinterHostAddress "192.168.100.100"


# Add printer
Add-Printer -Name "Friendly Name" -DriverName "Microsoft XPS Document Writer v4" -PortName "portprompt:"
# Add from network share 
Add-Printer -ConnectionName \\printServer\printerName

