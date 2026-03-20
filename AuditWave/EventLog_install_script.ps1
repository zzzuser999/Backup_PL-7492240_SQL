New-EventLog -LogName Application -Source AuditWaveScripting -erroraction 'silentlycontinue'

$now = get-date -format s

$appLogProps=Get-WinEvent -ListLog Application | Format-List -Property *

$oldestEvent=Get-WinEvent -LogName Application -MaxEvents 1 -Oldest

$diskspaceMB=Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object -Property DeviceID,@{'Name' = 'FreeSpace (MB)'; Expression= { [int]($_.FreeSpace / 1MB) }}

$diskspaceGB=Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object -Property DeviceID,@{'Name' = 'FreeSpace (GB)'; Expression= { [int]($_.FreeSpace / 1GB) }}

$output=$appLogProps+">>>Oldest event found in log:"+$oldestEvent+"`r`n>>>Scrtipt execution timestamp:"+$now+"`r`n>>Disk Free Space MB:"+$diskspaceMB+"`r`n>>Disk Free Space GB:"+$diskspaceGB

$outputStr= Out-String -InputObject $output -Width 160

Write-EventLog -LogName Application -Source "AuditWaveScripting" -EventID 6666 -Message $outputStr

Write-Output "Application log details saved to Application log... "