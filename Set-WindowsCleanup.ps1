<#
    .SYNOPSIS
        This script sets up Windows Cleanup on Windows 10 or 11 to run with all options selected as a weekly scheduled task.
        The scheduled task will run every Friday at 10AM.

    .Notes
        Version: 1.0
        Authors: Nick Ellis
        Purpose: Windows cleanup options tend to change with each version of Windows 10/11. This script can be run to capture all
        available options and run with all options selected.
#>

$options = Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\'

foreach ($option in $options)
{
    $path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\$($option.Name.Split('\')[7])"
    $flags = Get-ItemProperty -Path $path
    if (-not $flags.StateFlags0010)
    {
        New-ItemProperty -Path $path -Name 'StateFlags0010' -PropertyType DWord -Value 2
    }
    elseif ($flags.StateFlags0010 -ne 2)
    {
        Set-ItemProperty -Path $path -Name 'StateFlags0010' -Value 2
    }
}

$action = New-ScheduledTaskAction -Execute 'Cleanmgr.exe' -Argument '/sagerun:10 /verylowdisk'
$trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 2 -DaysOfWeek Friday -At 10am
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -Compatibility Win8 -StartWhenAvailable
$task = New-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -Settings $settings


$scheduledTask = Get-ScheduledTask -TaskName 'Automated Disk Cleanup' -ErrorAction SilentlyContinue

if ($null -eq $scheduledTask)
{
    Register-ScheduledTask -TaskName 'Automated Disk Cleanup' -InputObject $task
}
else
{
    Unregister-ScheduledTask -TaskName 'Automated Disk Cleanup' -Confirm:$false
    Register-ScheduledTask -TaskName 'Automated Disk Cleanup' -InputObject $task
}

Start-ScheduledTask 'Automated Disk Cleanup'
