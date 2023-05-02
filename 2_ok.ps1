#region setup
clear-host
import-module .\secrets.psm1 -force 
Import-Module SwisPowerShell
Import-Module .\3_better.psm1	

$hostname = 'se-orion01.emea.sales'
$text = ".\encrypted_password1.txt"
$cred = get-credentialusingpasswordfromfile ( $text)

$swis  = Connect-Swis -Credential  $cred -Hostname $hostname
reset-unmanagednodes($swis)
#endregion setup

import-module .\2_ok.psm1 

$ids = get-nodeids ($swis)

set-unmanage($ids) 