<#
    .SYNOPSIS
        This script gets the last 6 digits of the machine's serial number and sets it as the bitlocker
        pin. This can be used when an organization changes from a competing solution to bitlocker, or can
        be used as part of an organization's imaging process to set the bitlocker pin at imaging time.

    .Notes
        Version: 1.0
        Authors: Nick Ellis
#>

$serial = (Get-WmiObject win32_bios).serialnumber
$lastSix = $serial.substring($SERIAL.length -6, 6)
Write-Host Setting Bitlocker PIN to "$lastSix"
Manage-BDE -Protectors -Add c: -TPMAndPIN $lastSix
