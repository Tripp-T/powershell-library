#Requires -RunAsAdministrator

$certificateSubject = Read-Host -Prompt "Please enter a valid certificate subject name"

$invalidCharacters = '?><!@#$%^&*()_+-=`~\/|{}[].,'
if ( -not $certificateSubject -or $certificateSubject.IndexOfAny($invalidCharacters.ToCharArray()) -gt -1 ) {
    Write-Host "A valid certificate name was not provided."
    return
}

# Generate a self-signed Authenticode certificate in the current users's personal certificate store.
$CertParams = @{    
    Subject           = "CN=$certificateSubject"
    Type              = "CodeSigningCert"    
    KeySpec           = "Signature"     
    KeyUsage          = "DigitalSignature"    
    FriendlyName      = "$certificateSubject"    
    NotAfter          = [datetime]::now.AddYears(5)    
    CertStoreLocation = 'Cert:\CurrentUser\My' 
}

$newCertificate = New-SelfSignedCertificate @CertParams
Write-Host "Created certificate & added certificate to Cert:\LocalMachine\My.."

# Add new certificate to root certificate store.
$rootCertificateStore = [System.Security.Cryptography.X509Certificates.X509Store]::new("Root","LocalMachine")
$rootCertificateStore.Open("ReadWrite")
$rootCertificateStore.Add($newCertificate)
$rootCertificateStore.Close()
Write-Host "Added certificate to Cert:\LocalMachine\Root.."

# Add new certificate to publisher certificate store.
$publisherCertificateStore = [System.Security.Cryptography.X509Certificates.X509Store]::new("TrustedPublisher","LocalMachine")
$publisherCertificateStore.Open("ReadWrite")
$publisherCertificateStore.Add($newCertificate)
$publisherCertificateStore.Close()
Write-Host "Added certificate to Cert:\LocalMachine\TrustedPublisher.."

# This certificate can then be used to sign a PowerShell script like in the example below.
# $codeCertificate = Get-ChildItem Cert:\CurrentUser\My | Where-Object {$_.Subject -eq "CN=certificateSubject"}
# Set-AuthenticodeSignature -FilePath "$PWD\myscript.ps1" -Certificate $codeCertificate -TimeStampServer *<http://timestamp.digicert.com>*
