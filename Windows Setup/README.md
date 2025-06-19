# Windows Setup Automation Tutorial

## How to Setup autounattend.xml

1. Get a Windows Setup ISO with the Windows Creation Media Tool.
2. Install the ISO using a program like Rufus.
3. Place the autounattend.xml in the root directory of the USB stick. Example: D:/

## How to Setup SetupApps.ps1

1. Create a folder structure like this: "D:/$OEM$/$$/Setup/Scripts"
    - INFO: All files in $$ will be copied into the default Windows folder "C:/Windows". So everything in "C:/Windows/Setup/Scripts/" will be available as needed.
    - Further information about the technique of $OEM$:
        - '$1' => Windows primary disk
        - '$$' => Windows folder "C:/Windows"
        - 'Drivers' => Default folder to search for drivers. Will be automatically found if possible (cannot be .exe or .zip files)
2. Optional: Change the default setting in SetupApps.ps1
    @{ Name = "Google Chrome"; Id = "Google.Chrome"; Selected = $false; PostInstall = { } }
    For a default enable, set Selected to true ("$true").
    IMPORTANT: You do not need to do this. You can always select and deselect any program.

## 🔗 Helpful Links
- unattend-generator: https://schneegans.de/windows/unattend-generator/