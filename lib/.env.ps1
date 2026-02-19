# lib/env.ps1

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