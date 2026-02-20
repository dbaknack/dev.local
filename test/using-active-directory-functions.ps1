. ./lib/.env.ps1 ; Import-EnvFile

# functions to use
$functions = @(
    @{
        name = "active-directory-functions"
        path = "./lib/active-directory-functions.ps1"
    }
)
# work with credentials
$creds = set-creds -username $env:LAB_DC01_USERNAME -password $env:LAB_DC01_PASSWORD
$session = new-pssession -hostname $env:LAB_DC01_IP -Port $env:LAB_DC01_PORT -UserName $creds.username


# tasks definition
$tasks = @(
    @{
        name  = "check_dns_record"
        functions = @{
            "active-directory-functions" = (get-func_def -function ($functions | Where-Object {$_.name -eq "active-directory-functions"}))
        }
        params =  @{
            options = @{verbose = $false}
            zonename = "dev.local"
            name     = "test"
            rrtype   = "a"
        }
        scriptblock = {
            param([hashtable]$fromSender)
        
            # check if the record exists
            $ptrRecord = udf_dns_getdnsrecord $fromSender

            if($null -eq $ptrRecord){
                write-host "no record found" -f yellow
                return $null
            }
            return $ptrRecord
        }
    }
)

# task: check dns record exists (this works on windows, not on mac)
$results = Invoke-Command -Session $session -ScriptBlock {
    param($task)

    # variables
    $functions = $task.functions
    $scriptblock = [scriptblock]::create($task.scriptblock)
    $params = $task.params
    # define the functions
    invoke-expression ($functions["active-directory-functions"])
    $results = invoke-command -ScriptBlock $scriptblock -ArgumentList $params
    return $results
    

} -ArgumentList ($tasks | where-object {$_.name -eq "check_dns_record"}) 
return $results