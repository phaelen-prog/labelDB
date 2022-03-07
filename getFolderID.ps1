#Connect to O365 Exchange Online $null suppresses terminal output for connection
$null = Connect-ExchangeOnline -CertificateThumbPrint "23793c1567326c86fd729f4def64b2cc2ee1b44d" -AppID "d5f99f75-9f1b-453a-afa9-e555ccdeefce" -Organization "enginetech.onmicrosoft.com"

#make sure to point to mailbox that you want the folder IDs from
$mbx = "phaelen@enginetech.com"
$mbxStatistics = Get-MailboxFolderStatistics -Identity $mbx
$folderQueries = @()
foreach ($stat in $mbxStatistics){
    $folderName = $stat.Name
    $folderId = $stat.FolderId;
    $folderPath = $stat.FolderPath;
    $encoding = [System.Text.Encoding]::GetEncoding("us-ascii")
    $nibbler = $encoding.GetBytes("0123456789ABCDEF");
    $folderIdBytes = [Convert]::FromBase64String($folderId);
    $indexIdBytes = New-Object byte[] 48;
    $indexIdIdx = 0;
    $folderIdBytes | select -Skip 23 -First 24 | %{$indexIdBytes[$indexIdIdx++] = $nibbler[$_ -shr 4]; $indexIdBytes[$indexIdIdx++] = $nibbler[$_ -band 0xF]}
    $folderIdConverted = $($encoding.GetString($indexIdBytes))
    $folderDetails = New-Object PSObject
    Add-Member -InputObject $folderDetails -MemberType NoteProperty -Name FolderName -Value $folderName
    Add-Member -InputObject $folderDetails -MemberType NoteProperty -Name FolderId -Value $folderIdConverted
    Add-Member -InputObject $folderDetails -MemberType NoteProperty -Name FolderPath -Value $FolderPath
    $folderQueries += $folderDetails
}
$folderQueries