<#
    .SYNOPSIS
        This script modifies the default behavior of Window10 to alleviate common annoyances.

    .Notes
        Version: 1.0
        Authors: Nick Ellis
        Windows 8.1 and below are not supported.
#>

# Set search to icon from search bar
Set-ItemProperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Value '1'

# Hide people bar
New-Item -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
New-ItemProperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -name 'PeopleBand' -value '0'

# Stop OneDrive from starting with Windows
Remove-ItemProperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -name 'onedrive'

# Turn off Suggested Content
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338389Enabled' -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SystemPaneSuggestionsEnabled' -Value 0
New-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338388Enabled' -Value 0

# Remove Edge from "Open With" dialog for pdf files. Also stops Edge from taking over default file associations for pdf files.
New-ItemProperty -path 'HKCU:\Software\Classes\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723' -name 'NoOpenWith'
New-ItemProperty -path 'HKCU:\Software\Classes\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723' -name 'NoStaticDefaultVerb'

# Remove Edge Desktop Shortcut
Remove-Item -Path "$env:USERPROFILE\Desktop\Microsoft Edge.lnk"

# Remove Tak View Button from Taskbar
Set-ItemProperty -path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -name 'ShowTaskViewButton' -value '0' -Type 'DWORD'
