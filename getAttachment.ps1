#Importing Exchange Online module
#Import-Module ExchangeOnlineManagement
#Import-Module Microsoft.Graph.Mail

#Configure mailbox properties
$userId = 'phaelen@enginetech.com'
$folderID = '66DF478E71DDBF4BAFD4F5CF07FA97E700001F5894480000' 
$fileName = "$( $env:USERPROFILE )\Coding\labelDB\test.txt"
$tId = '2c89f133-08cf-46a4-ad4a-a4d82ec21b41'
$appId = 'd5f99f75-9f1b-453a-afa9-e555ccdeefce'
$cert = Get-ChildItem 'Cert:\LocalMachine\My\23793C1567326C86FD729F4DEF64B2CC2EE1B44D'


<#Connect to Exchange Online using app-only certificate. Cert is stored in localmachine cert store -> Cert:\LocalMachine\My
This needs Powershell 7.2 or higher to run, install 7 and modify settings.json to point to 7.2 shell
If this doesn't work and throws an error about a missing keyset, make sure the executing account can access the private key in the local cert store
null suppresses login output
Graph SKD for powershell looks at user cert store instead of local machine, need to provide path to cert thumprint as shown in $cert#>
$null = Connect-MgGraph -TenantId $tId -AppId $appId -Certificate $cert
#Connect-ExchangeOnline -CertificateThumbPrint "23793c1567326c86fd729f4def64b2cc2ee1b44d" -AppID "d5f99f75-9f1b-453a-afa9-e555ccdeefce" -Organization "enginetech.onmicrosoft.com"

#Get message from the specified user's folder
$msgs = Get-MgUserMailFolderMessage -UserId $userId -MailFolderId $folderID
$msgId = $msgs[0].Id

#get attachment
$attachment = Get-MgUserMailFolderMessageAttachment -UserId $userId -MailFolderId $folderID -MessageId $msgId

#get attachment as Base64
$base64B = ($attachment).AdditionalProperties.contentBytes
#could also use Get-MgUserMessageAttachment

#save base64 to file
$bytes = [Convert]::FromBase64String($base64B)
[IO.File]::WriteAllBytes($fileName, $bytes)

#exit session
Disconnect-MgGraph