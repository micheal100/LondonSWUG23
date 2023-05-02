#region setup
clear-host
import-module .\secrets.psm1 -force 
Import-Module SwisPowerShell

$hostname = 'se-orion01.emea.sales'
$text = ".\encrypted_password1.txt"
$cred = get-credentialusingpasswordfromfile ( $text)

$swis  = Connect-Swis -Credential  $cred -Hostname $hostname
reset-unmanagednodes($swis)
#endregion setup

import-module .\3_better.psm1

get-nodeids -swis $swis -Verbose

set-unmanage -swis $swis -ids 80, 81 -WhatIf
set-unmanage -swis $swis -ids a, b -WhatIf