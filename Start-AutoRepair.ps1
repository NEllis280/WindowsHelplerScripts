<#
    .SYNOPSIS
        This script deletes temp files and reboots the machine. The intent is to make the lives of helpdesk techs
        easier. They can have the user run the script to do normal cleanup operations and reboot, leaving less
        instruction to be given to end-users.

    .Notes
        Version: 1.0
        Authors: Nick Ellis
#>

Write-Verbose -Message 'Starting Automatic Repair of the Windows Environment'
Write-Verbose -Message 'Detecting Issues'
Start-Sleep -Seconds 20
Write-Verbose -Message 'Applying Potential Fixes'

$logdate = Get-Date
$days = '1'
$lastWrite = $logdate.AddDays(-$Days)

$tempDir = "$env:userprofile\AppData\Local\Temp\"
$tempFiles = Get-ChildItem -Path $tempDir -Recurse
foreach ($files in $tempFiles)
{
    if ($files.LastWriteTime -lt $lastWrite)
    {
        Remove-Item $files.FullName -Recurse -Force
    }

}

#Chrome cleanup portion
$cleanupItems = @('Archived History', 'Cache\*', 'Cookies', 'Media Cache', 'Top Sites', 'Visited Links', 'Web Data')
$folder = "$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default"

foreach ($item in $cleanupItems)
{
    if (Test-Path "$folder\$item")
    {
        Remove-Item "$folder\$item" -Recurse -Force
    }
}

Write-Verbose -Message 'Your Machine Will Reboot in 30 Seconds'
Shutdown /f /r /t 30
