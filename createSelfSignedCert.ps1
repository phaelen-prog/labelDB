#Create self signed cert
#$mycert = New-SelfSignedCertificate -DnsName "enginetech.com" -CertStoreLocation "cert:\CurrentUser\My" -NotAfter (Get-Date).AddYears(1) -KeySpec KeyExchange

#Export certificate to .pfx
#$mycert | Export-PfxCertificate -FilePath mycert.pfx -Password $(ConvertTo-SecureString -String "Rena1ssanceman" -AsPlainText -Force)

#Export to .cer
#$mycert | Export-Certificate -FilePath mycert.cer


#this creates a self signed cert for the current date for the next year
$mycert = New-SelfSignedCertificate -DnsName "enginetech.com" -CertStoreLocation "cert:\LocalMachine\My" -NotAfter (Get-Date).AddYears(1) -KeySpec KeyExchange
#export the cert to a .cer file, located in current dir of pssession
$mycert | Export-Certificate -FilePath mycert.cer