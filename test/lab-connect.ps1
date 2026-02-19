. ./lib/.env.ps1; import-envfile
$session = New-PSSession -HostName $env:LAB_DC01_IP -Port $env:LAB_DC01_PORT -UserName $env:LAB_USER