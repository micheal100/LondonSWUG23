
#function to return the node IDs and captions of nodes with the Custom Property "To Unmanage" set
function get-nodeids {
    [CmdletBinding()]
    param (
        #Swis Connection, from Connect-Swis
        [Parameter(Mandatory=$true)]
        $swis
    )
    
    begin {
        $swql = 'SELECT nodeid from orion.nodes n where n.CustomProperties.ToUnmanage = "True" '
    }
    
    process {
        write-verbose "Calling $swql"
        $results = Get-SwisData -SwisConnection $swis -query $swql
    }
    
    end {
        Write-Verbose "Outputting results from get-nodeids"
        Write-Output $results
    }
}


#basic function to unmanage nodes based on ID for one hour
function set-unmanage {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        #Swis Connection, from Connect-Swis
        [Parameter(Mandatory=$true)]
        $swis,

        [Parameter(Mandatory=$true)]
        [int32[]]$ids,

        $StartTime = (Get-Date).ToUniversalTime(),
        $EndTime = (Get-Date).ToUniversalTime().AddHours(1)
    )
    
    begin {
        Write-Debug "Starttime : $starttime"
        Write-Debug "Endtime : $Endtime"
    }
    
    process {
        ForEach ($id in $ids){
            
            If ($PSCmdlet.ShouldProcess("$id","Unmanage Node")) {
                write-verbose "Unmanaging nodeid: $id"
                Invoke-SwisVerb $swis Orion.Nodes Unmanage @("N:$Id",$StartTime,$EndTime, $false)  | Out-Null
            }
        }
    }
       
}