write-host "loading .env.ps1" -f "yellow"

function Import-EnvFile {
    param (
        [string]$Path = ".env"
    )

    if (Test-Path $Path) {
        Get-Content $Path | ForEach-Object {
            if ($_ -match "^\s*([^#][^=]+)=(.+)$") {
                $name = $matches[1].Trim()
                $value = $matches[2].Trim()
                Set-Item -Path "Env:$name" -Value $value
            }
        }
    }
}

function set-creds {
    param(
        [string]$username,
        [string]$password
    )
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    $credential_wrapper = New-Object System.Management.Automation.PSCredential ($username, $securePassword)
    return $credential_wrapper
}

function get-func_def {
    param(
        [hashtable]$function
    )
    $func_def = Get-Content $function.path -Raw
    return $func_def
}