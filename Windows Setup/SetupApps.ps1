# Define applications
enum InstallType {
    Winget
    SetupScript
}

class Category {
    [string]$Name
    [array]$Items

    Category([string]$name, [array]$items) {
        $this.Name = $name
        $this.Items = $items
    }
}

class Item {
    [string]$Name

    # Application ID for winget or FileName for setup scripts
    # If you use a setup script, the Id should be the name of the script file with extension.
    # For example, if the script is "GoogleChromeSetup.exe", the Id should be "GoogleChromeSetup.exe".
    # The Script should be located in "C:\Windows\Setup\Scripts\Software\".
    [string]$Id  
    [bool]$Selected
    [scriptblock]$PostInstall
    [InstallType]$InstallType

    # Index for Installation order.
    # The Lowest index will be installed first.
    # Default: 1000
    [int]$index 

    Item([string]$name, [string]$id, [bool]$selected, [scriptblock]$postInstall, [InstallType]$installType = [InstallType]::Winget, [int]$index = 1000) {
        $this.Name = $name
        $this.Id = $id
        $this.Selected = $selected
        $this.PostInstall = $postInstall
        $this.InstallType = $installType
        $this.index = $index
    }
}

$groups = @(
    [Category]::new(
        "Browser",
        @(
            [Item]::new("Google Chrome", "Google.Chrome", $false, { }),
            [Item]::new("Mozilla Firefox", "Mozilla.Firefox", $false, { })
        )
    ),
    [Category]::new(
        "Archivierung & Packprogramme",
        @(
            [Item]::new(
                "WinRAR",
                "RARLab.WinRAR",
                $false,
                {
                    if (Test-Path "C:\Windows\Setup\Scripts\rarreg.key") {
                        Copy-Item "C:\Windows\Setup\Scripts\rarreg.key" -Destination "$env:ProgramFiles\WinRAR\" -Force
                    }
                },
                [InstallType]::Winget
            ),
            [Item]::new("7-Zip", "7zip.7zip", $true, { })
        )
    ),
    [Category]::new(
        "Gaming",
        @(
            [Item]::new("Steam", "Valve.Steam", $true, { }),
            [Item]::new("Battle.net", "Blizzard.BattleNet", $false, { }),
            [Item]::new("Epic Games Launcher", "EpicGames.EpicGamesLauncher", $false, { }),
            [Item]::new("EA Launcher", "ElectronicArts.EADesktop", $false, { }),
            [Item]::new("League Of Legends ( Maybe nur Riot Client download )", "RiotGames.LeagueOfLegends.EUW", $false, { }),
            [Item]::new("Valorant ( Maybe nur Riot Client download )", "RiotGames.Valorant.EU", $false, { })
        )
    ),
    [Category]::new(
        "Multimedia & Kommunikation",
        @(
            [Item]::new("VLC Player", "VideoLAN.VLC", $false, { }),
            [Item]::new("GIMP", "GIMP.GIMP", $false, { }),
            [Item]::new("Bambu Lab Studio", "bambulab.bambulab-studio", $false, { }),
            [Item]::new("Teamspeak 6", "TeamSpeakSystems.TeamSpeak", $false, { }),
            [Item]::new("Whatsapp", "9NKSQGP7F2NH", $true, { }),
            [Item]::new("Whatsapp Beta", "9NBDXK71NK08", $true, { }),
            [Item]::new("OBS Studio", "OBSProject.OBSStudio", $true, { }),
            [Item]::new("Discord", "Discord.Discord", $true, { })
        )
    ),
    [Category]::new(
        "Tools & Dienstprogramme",
        @(
            [Item]::new("CPU-Z", "CPUID.CPU-Z", $true, { }),
            [Item]::new("Wireshark", "WiresharkFoundation.Wireshark", $false, { }),
            [Item]::new(".NET Framework Developer Pack", "Microsoft.DotNet.Framework.DeveloperPack_4", $false, { }),
            [Item]::new("WinOF - Network Driver", "WinOF", $false, { }, $InstallType::SetupScript, 0),
            [Item]::new("Lightshot", "Skillbrains.Lightshot", $false, { }),
            [Item]::new("Bitwarden", "Bitwarden.Bitwarden", $false, { }),
            [Item]::new("Languagetool", "9PFZ3G4D1C9R", $false, { })
        )
    ),
    [Category]::new(
        "Entwicklung & Editoren",
        @(
            [Item]::new("Notepad++", "Notepad++.Notepad++", $false, { }),
            [Item]::new("Visual Studio Code", "Microsoft.VisualStudioCode", $true, { }),
            [Item]::new("Jetbrains Toolbox", "XPFPPN5PLH3BFV", $true, { }),
            [Item]::new("Git", "Git.Git", $true, { }),
            [Item]::new("Windows Terminal", "Microsoft.WindowsTerminal", $true, { }),
            [Item]::new("Oh My Posh", "JanDeDobbeleer.OhMyPosh", $true, { })
        )
    ),
    [Category]::new(
        "Dateiübertragung & Remote-Zugriff",
        @(
            [Item]::new("MobaXterm", "Mobatek.MobaXterm", $false, { }),
            [Item]::new("WinSCP", "WinSCP.WinSCP", $false, { }),
            [Item]::new("TeamViewer", "TeamViewer.TeamViewer", $false, { }),
            [Item]::new("AnyDesk", "AnyDeskSoftwareGmbH.AnyDesk", $false, { })
        )
    )
)

# Interaktive App-Auswahl mit Gruppierung und Tastennavigation

# Flache Liste mit Gruppentyp für Navigation erzeugen
$flatList = @()
foreach ($group in $groups) {
    $flatList += @{ Type = "Group"; Label = $group.Name }
    foreach ($item in $group.Items) {
        $flatList += @{ Type = "Item"; Ref = $item }
    }
}

$index = 0
$done = $false

function DrawMenu {
    Clear-Host
    Write-Host "Wähle die Programme mit [Enter] aus. Starte Installation mit [Q]. Pfeiltasten zum Navigieren.`n"

    for ($i = 0; $i -lt $flatList.Count; $i++) {
        $entry = $flatList[$i]

        if ($entry.Type -eq "Group") {
            Write-Host ""
            Write-Host "$($entry.Label)" -ForegroundColor Cyan
        }
        elseif ($entry.Type -eq "Item") {
            $highlight = if ($i -eq $index) { ">" } else { " " }
            $prefix    = if ($entry.Ref.Selected) { "[X]" } else { "[ ]" }
            $name      = $entry.Ref.Name
            Write-Host "$highlight $prefix $name"
        }
    }
}

while (-not $done) {
    DrawMenu
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    switch ($key.VirtualKeyCode) {
        38 {  # Up
            do {
                $index = if ($index -gt 0) { $index - 1 } else { $flatList.Count - 1 }
            } while ($flatList[$index].Type -ne "Item")
        }
        40 {  # Down
            do {
                $index = if ($index -lt $flatList.Count - 1) { $index + 1 } else { 0 }
            } while ($flatList[$index].Type -ne "Item")
        }
        13 {  # Enter toggles selection
            $flatList[$index].Ref.Selected = -not $flatList[$index].Ref.Selected
        }
        81 { $done = $true }  # Q to quit
    }
}

# Installationsteil
Clear-Host
Write-Host "`nStarte Installation:`n"

# Alle ausgewählten Apps in eine flache Liste sammeln und nach Index sortieren
$selectedApps = @()
foreach ($group in $groups) {
    foreach ($app in $group.Items) {
        if ($app.Selected) {
            $selectedApps += $app
        }
    }
}
$selectedApps = $selectedApps | Sort-Object index

foreach ($app in $selectedApps) {
    Write-Host "Installiere $($app.Name)..."
    try {
        switch ($app.InstallType) {
            'Winget' {
                winget install --id $app.Id -e --silent --accept-package-agreements --accept-source-agreements
            }
            'SetupScript' {
                $scriptPath = "C:\Windows\Setup\Scripts\Software\$($app.Id)"
                if (Test-Path $scriptPath) {
                    Write-Host "Führe SetupScript für $($app.Name) aus: $scriptPath"
                    & $scriptPath
                } else {
                    Write-Host "Kein SetupScript für $($app.Name) gefunden unter $scriptPath." -ForegroundColor Yellow
                }
            }
            default {
                Write-Host "Unbekannter InstallType für $($app.Name): $($app.InstallType)" -ForegroundColor Yellow
            }
        }
        if ($app.PostInstall) {
            Write-Host "Führe Post-Installationsschritte für $($app.Name) aus..."
            & $app.PostInstall
            Write-Host "Post-Installationsschritte abgeschlossen für: $($app.Name)" -ForegroundColor Green
        }
        Write-Host "Erfolgreich installiert: $($app.Name)" -ForegroundColor Green
    } catch {
        Write-Host "Fehler bei $($app.Name): $_" -ForegroundColor Red
    }
}

Write-Host "`nAlle ausgewählten Programme wurden verarbeitet." -ForegroundColor Green

Write-Host "`nEntferne Desktop-Verknüpfungen..."
Remove-Item "$env:PUBLIC\Desktop\*.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:USERPROFILE\Desktop\*.lnk" -Force -ErrorAction SilentlyContinue

Write-Host "`nAktualisiere installierte Programme..."
winget upgrade --all --accept-package-agreements --accept-source-agreements

Write-Host "`nInstalliere Windows Update Ohne Reboot"
Install-WindowsUpdate -AcceptAll -IgnoreReboot

Write-Host "`nLösche Alle Dateien im TEMP Ordner"
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

$choice = Read-Host "System jetzt neu starten? (J/N)"
if ($choice -eq "J") {
    Restart-Computer -Force
}
