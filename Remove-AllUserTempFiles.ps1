<#
    .SYNOPSIS
        This script cleans up temp files for all users on a machine. Chrome temp files are included for
        convenience. This script can be set to run as a startup script or called by a scheduled task to ensure 
        user's temp files are cleaned up on a regular basis.

    .Notes
        Version: 1.0
        Authors: Nick Ellis
#>

$root = 'c:\users'
$logdate = Get-date
$days = '1'
$lastWrite = $logdate.AddDays(-$Days)
$users = Get-ChildItem -Path $root -Exclude administrator, public

foreach ($user in $users)
{
    $folder = Join-Path -Path $user -ChildPath 'AppData\Local\Temp'
    $tempFiles = Get-childItem $folder -Recurse
    foreach ($files in $tempFiles)
    {
        if ($files.LastWriteTime -lt $lastWrite)
        {
            Remove-Item $files.FullName -Recurse -Force
        }
    }

    # Clean up chrome temp files
    $chromeFolder = Join-Path -Path $user -ChildPath 'AppData\Local\Google\Chrome\User Data\Default'
    $items = @('Archived History','Cache\*','Cookies','Media Cache','Top Sites','Visited Links','Web Data')

    foreach ($item in $items)
    {
        if (Test-Path "$chromeFolder\$item")
        {
            Remove-Item "$chromeFolder\$item" -Recurse -Force
        }
    }
}
