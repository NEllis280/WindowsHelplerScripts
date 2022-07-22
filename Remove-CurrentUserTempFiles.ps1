<#
    .SYNOPSIS
        This script cleans up temp files for the current user. Chrome temp files are included for convenience.
        This script can be set to run as a logon script or called by a scheduled task to ensure user's temp 
        files are cleaned up on a regular basis.

    .Notes
        Version: 1.0
        Authors: Nick Ellis
#>

$logdate = Get-date
$days = '1'
$lastWrite = $logdate.AddDays(-$Days)
$tempDir = "$env:USERPROFILE\AppData\Local\Temp\*"
$tempFiles = Get-ChildItem -Path $tempDir -Recurse

foreach ($file in $tempFiles)
{
    if ($file.LastWriteTime -lt $lastWrite)
    {
        Remove-item $file.FullName -Recurse -Force -ErrorAction SilentlyContinue
    }
}

# Clean up chrome temp files
$items = @('Archived History','Cache\*','Cookies','Media Cache','Top Sites','Visited Links','Web Data')
$folder = "$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default"

foreach ($item in $items)
{
    if (Test-Path "$folder\$item")
    {
        Remove-Item "$folder\$item" -Recurse -Force -ErrorAction SilentlyContinue
    }
}
