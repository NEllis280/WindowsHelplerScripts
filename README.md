# WindowsHelplerScripts
A Collection of Helper Scripts for Windows 10/11

## Contents

- **Remove-AllUserTempFiles.ps1**: This is a script that cleans the temp files for all
users on a machine. It is intended for shared machines in a domain environment.

- **Remove-CurrentUserTempFiles.ps1**: This is a script that cleans the temp files for the
current user. I run this on my machines at home as a scheduled task to keep temp files
clean.

- **Set-BitLockerDefaultPin.ps1**: This is a script that sets the default BitLocker pin on
a machine to the last 6 digits of the machine's serial number. I find it useful for setting
a default pin and OSD/Image time for organizations that use BitLocker with the pin requirement.

- **Set-DefaultsWindows10.ps1**: This is a script that I use for initial setup on Windows 10
machines to automate some things that I commonly set on my machines at home, such as removing
task view and people from the taskbar.

- **Set-WindowsCleanup.ps1**: This is a script that can be run at image time, when standing up a
new Windows 10/11 computer, or after a feature upgrade. The script automates Windows cleanup,
setting it to run weekly as a scheduled task with all available options selected.

- **Start-AutoRepair.ps1**: This is a script that, when run in a user's context, will clean up
temp files and reboot the machine, while providing some verbose output to make it look like an
auto-repair. This is intended for HelpDesk business units to make their lives easier.
