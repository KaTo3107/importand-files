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

## Where to Place Additional Software Installers

To automate the installation of extra software during Windows setup, place your installer files (e.g., `.exe`, `.msi`) in the following folder on your USB drive/ISO File:

```
D:/$OEM$/$$/Setup/Scripts/Software
```

- All files in this `Software` directory will be available at `C:\Windows\Setup\Scripts\Software` during Windows installation.
- You can reference these installers in your `SetupApps.ps1` script for silent or unattended installations.
- Make sure your installer filenames match those referenced in your script.

**Example:**
```
D:/$OEM$/$$/Setup/Scripts/Software/7zSetup.exe
D:/$OEM$/$$/Setup/Scripts/Software/ChromeSetup.exe
```

These files will be copied automatically and can be executed as part of your setup automation.

## 🔗 Helpful Links
- unattend-generator: https://schneegans.de/windows/unattend-generator/