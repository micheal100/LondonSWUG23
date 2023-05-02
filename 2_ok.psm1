
#function to return the node IDs and captions of nodes with the Custom Property "To Unmanage" set
function get-nodeids ($swis){
    $swql = 'SELECT nodeid from orion.nodes n where n.CustomProperties.ToUnmanage = "True" '

    $results = Get-SwisData -SwisConnection $swis -query $swql
    $results
    
}

#basic function to unmanage nodes based on ID for one hour
function set-unmanage([int32[]]$ids){
    $StartTime = (Get-Date).ToUniversalTime()
    $EndTime = (Get-Date).ToUniversalTime().AddHours(1)
    
    ForEach ($id in $ids){
        
        Invoke-SwisVerb $swis Orion.Nodes Unmanage @("N:$Id",$StartTime,$EndTime, $false)  | Out-Null
    }
}