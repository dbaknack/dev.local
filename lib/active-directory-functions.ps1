write-host "loading active-directory-functions.ps1" -f "yellow"
## import-module dnsserver, activedirectory

## functions
function udf_dns_getdnsrecord {
    param([hashtable]$fromSender)
    $ErrorActionPreference = 'silentlycontinue'

    $myParams = @{
        ZoneName = $fromSender.zonename
        Name     = $fromSender.name
        RRType   = $fromSender.rrtype

    }

    Get-DnsServerResourceRecord @myParams -ErrorAction SilentlyContinue
}

function udf_dns_creatednsrecord {
    param([hashtable]$fromSender)
    $erroractionpreference = "silentlycontinue"

    $options = $fromSender.options
    
    $myparams = @{
        name = $fromSender.name
        zonename = $fromSender.zonename
        ipv4address = $fromSender.ipv4address
        createptr = $fromSender.createptr
    }


    add-dnsserverresourcerecorda @myparams
}

# if($null -ne $ptrRecord){
#     $RemoveParams = @{
#         ZoneName     = "dev.local"
#         InputObject  = $ptrRecord
#         Force        = $true
#     }

#     Remove-DnsServerResourceRecord @RemoveParams 
# }

# # create the record
# udf_dns_creatednsrecord @{
#     options = @{verbose = $true}
#     zonename    = "dev.local"
#     name        = "test"
#     ipv4address = "10.0.10.32"
#     createptr   = $true
#     rrtype = "a"
# }
