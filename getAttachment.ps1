#Importing Exchange Online module
Import-Module ExchangeOnlineManagement

<#Mailbox Login Info (deperecated)
$username = 'phaelen@enginetech.com'
$password = Get-Content "C:\Users\Phaelen\Coding\labelDB\creds\encryptpass.txt" | ConvertTo-SecureString
$credentials = New-Object System.Management.Automation.PSCredential $username.$password 'Rena1ssanceman'#>

<#Connect to Exchange Online using app-only certificate. Cert is stored in user cert store -> personal
This needs Powershell 7.2 or higher to run, install 7 and modify settings.json to point to 7.2 shell
If this doesn't work and throws an error about a missing keyset, make sure the executing account can access the private key in the local cert store#>

Connect-ExchangeOnline -UserPrincipalName "phaelen@enginetech.com" -CertificateThumbPrint "23793c1567326c86fd729f4def64b2cc2ee1b44d" -AppID "d5f99f75-9f1b-453a-afa9-e555ccdeefce" -Organization "enginetech.onmicrosoft.com"
