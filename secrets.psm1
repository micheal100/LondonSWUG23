function set-passwordtofile($file){
    
    $credential = Get-Credential
    $credential.Password | ConvertFrom-SecureString | Set-Content $file
}

function get-credentialusingpasswordfromfile( $file){
   
    $encrypted = Get-Content $file | ConvertTo-SecureString
    $credential = New-Object System.Management.Automation.PsCredential('<username>', $encrypted)
    Write-Output $credential
}

function reset-unmanagednodes($swis){
    [CmdletBinding()]
    
    $NodeIDs =  Get-SwisData -SwisConnection $swis -Query "SELECT n.nodeid from orion.nodes n where n.CustomProperties.ToUnmanage = 'True'"
ForEach ($Id in $NodeIDs){
    write-verbose "Remanaging Node $id"
    Invoke-SwisVerb $swis Orion.Nodes Remanage @("N:$Id") >> $null
} 

ForEach ($Id in $NodeIDs){
    write-verbose "Polling Node $id"
    Invoke-SwisVerb $swis Orion.Nodes Pollnow @("N:$Id") >> $null
}

}