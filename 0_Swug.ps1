import-module .\secrets.psm1 -force 
Import-Module SwisPowerShell

$hostname = 'se-orion01.emea.sales'
$text = ".\encrypted_password1.txt"
$cred = get-credentialusingpasswordfromfile ( $text)

$swis  = Connect-Swis -Credential  $cred -Hostname $hostname

reset-unmanagednodes($swis) >> $null