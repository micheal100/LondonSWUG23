#region setup
clear-host
import-module .\secrets.psm1 -force 
Import-Module SwisPowerShell
Import-Module .\3_better.psm1	

$hostname = 'se-orion01.emea.sales'
$text = ".\encrypted_password1.txt"
$cred = get-credentialusingpasswordfromfile ( $text)

$swis  = Connect-Swis -Credential  $cred -Hostname $hostname

#endregion setup

Describe  'get-nodeids' {
    Context "When called with default test system"{
        it "runs without error"{
            {get-nodeids($swis)} | should -Not -throw
        }
        it "returns 4 nodeids"{
            $results = get-nodeids($swis)
            $results.Count | should -be 6
        }
    }
    Context "When called no connection"{
        it "runs should throw an error"{
            {get-nodeids($null)} | should   -throw
        }
    }
}
   
Describe  'set-unmanage' {
  BeforeAll{
            [int32[]]$ids = '80','81','82','83'
        }
    Context "When called with clean parameters"{
      
        it "runs without error for a single id"{
            {set-unmanage -swis $swis -ids '80'} | should -Not -throw
        }

        it "runs without error for multiple ids"{
            {set-unmanage -swis $swis -ids $ids} | should -Not -throw
        }
       

        
    }



}

