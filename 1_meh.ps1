Clear-Host
Import-Module .\secrets.psm1 -force 
Import-Module SwisPowerShell

$hostname = 'se-orion01.emea.sales'
$text = ".\encrypted_password1.txt"
$cred = get-credentialusingpasswordfromfile ( $text)

#Build the connection to the HCO server
$swis  = Connect-Swis -Credential  $cred -Hostname $hostname

#make sure it's reset before starting!
reset-unmanagednodes($swis) 
#Get a list of nodeids, based on a custom property
$swql = 'SELECT nodeid from orion.nodes n where n.CustomProperties.ToUnmanage = "True" '
$ids = Get-SwisData -SwisConnection $swis -query $swql

#set start and end time
$StartTime = (Get-Date).ToUniversalTime()
$EndTime = (Get-Date).ToUniversalTime().AddHours(1)

#cycle through IDs, and call invoke-swis to unmanage each one
ForEach ($id in $ids){
    
    Invoke-SwisVerb -SwisConnection $swis -EntityName Orion.Nodes -verb Unmanage @("N:$Id",$StartTime,$EndTime, $false)  | Out-Null
}