# Define applications
$groups = @(
    @{ 
        Category = "Browser"
        Items = @(
            @{ Name = "Google Chrome"; Id = "Google.Chrome"; Selected = $false; PostInstall = { } },
            @{ Name = "Mozilla Firefox"; Id = "Mozilla.Firefox"; Selected = $false; PostInstall = { } }
        )
    },
    @{ 
        Category = "Archivierung & Packprogramme"
        Items = @(
            @{ Name = "WinRAR"; Id = "RARLab.WinRAR"; Selected = $false; PostInstall = { } },
            @{ Name = "7-Zip"; Id = "7zip.7zip"; Selected = $true; PostInstall = {
                    if (Test-Path "C:\Windows\Setup\Scripts\rarreg.key") {
                        Copy-Item "C:\Windows\Setup\Scripts\rarreg.key" -Destination "$env:ProgramFiles\WinRAR\" -Force
                    }
                }  
            }
        )
    },
    @{
        Category = "Gaming"
        Items = @(
            @{ Name = "Steam"; Id = "Valve.Steam"; Selected = $true; PostInstall = { } },
            @{ Name = "Battle.net"; Id = "Blizzard.BattleNet"; Selected = $false; PostInstall = { } },
            @{ Name = "Epic Games Launcher"; Id = "EpicGames.EpicGamesLauncher"; Selected = $false; PostInstall = { } },
            @{ Name = "EA Launcher"; Id = "ElectronicArts.EADesktop"; Selected = $false; PostInstall = { } },
            @{ Name = "League Of Legends ( Maybe nur Riot Client download )"; Id = "RiotGames.LeagueOfLegends.EUW"; Selected = $false; PostInstall = { } },
            @{ Name = "Valorant ( Maybe nur Riot Client download )"; Id = "RiotGames.Valorant.EU"; Selected = $false; PostInstall = { } }
        )
    },
    @{ 
        Category = "Multimedia & Kommunikation"
        Items = @(
            @{ Name = "VLC Player"; Id = "VideoLAN.VLC"; Selected = $false; PostInstall = { } },
            @{ Name = "GIMP"; Id = "GIMP.GIMP"; Selected = $false; PostInstall = { } },
            @{ Name = "Bambu Lab Studio"; Id = "bambulab.bambulab-studio"; Selected = $false; PostInstall = { } },
            @{ Name = "Teamspeak 6"; Id = "TeamSpeakSystems.TeamSpeak"; Selected = $false; PostInstall = { } },
            @{ Name = "Whatsapp"; Id = "9NKSQGP7F2NH"; Selected = $true; PostInstall = { } },
            @{ Name = "Whatsapp Beta"; Id = "9NBDXK71NK08"; Selected = $true; PostInstall = { } },
            @{ Name = "OBS Studio"; Id = "OBSProject.OBSStudio"; Selected = $true; PostInstall = { } },
            @{ Name = "Discord"; Id = "Discord.Discord"; Selected = $true; PostInstall = { } }
        )
    },
    @{ 
        Category = "Tools & Dienstprogramme"
        Items = @(
            @{ Name = "CPU-Z"; Id = "CPUID.CPU-Z"; Selected = $true; PostInstall = { } },
            @{ Name = "Wireshark"; Id = "WiresharkFoundation.Wireshark"; Selected = $false; PostInstall = { } },
            @{ Name = ".NET Framework Developer Pack"; Id = "Microsoft.DotNet.Framework.DeveloperPack_4"; Selected = $false; PostInstall = { } },
            @{ Name = "NVIDIA Treiber (WinOF 1)"; Id = "Mellanox.MFT"; Selected = $false; PostInstall = { } },
            @{ Name = "NVIDIA Treiber (WinOF 2)"; Id = "Mellanox.WinOF2"; Selected = $false; PostInstall = { } },
            @{ Name = "Lightshot"; Id = "Skillbrains.Lightshot"; Selected = $false; PostInstall = { } },
            @{ Name = "Bitwarden"; Id = "Bitwarden.Bitwarden"; Selected = $false; PostInstall = { } },
            @{ Name = "Languagetool"; Id = "9PFZ3G4D1C9R"; Selected = $false; PostInstall = { } }
        )
    },
    @{ 
        Category = "Entwicklung & Editoren"
        Items = @(
            @{ Name = "Notepad++"; Id = "Notepad++.Notepad++"; Selected = $false; PostInstall = { } },
            @{ Name = "Visual Studio Code"; Id = "Microsoft.VisualStudioCode"; Selected = $true; PostInstall = { } },
            @{ Name = "Jetbrains Toolbox"; Id = "XPFPPN5PLH3BFV"; Selected = $true; PostInstall = { } },
            @{ Name = "Git"; Id = "Git.Git"; Selected = $true; PostInstall = { } },
            @{ Name = "Windows Terminal"; Id = "Microsoft.WindowsTerminal"; Selected = $true; PostInstall = { } },
            @{ Name = "Oh My Posh"; Id = "JanDeDobbeleer.OhMyPosh"; Selected = $true; PostInstall = { } }
        )
    },
    @{ 
        Category = "Dateiübertragung & Remote-Zugriff"
        Items = @(
            @{ Name = "MobaXterm"; Id = "Mobatek.MobaXterm"; Selected = $false; PostInstall = { } },
            @{ Name = "WinSCP"; Id = "WinSCP.WinSCP"; Selected = $false; PostInstall = { } },
            @{ Name = "TeamViewer"; Id = "TeamViewer.TeamViewer"; Selected = $false; PostInstall = { } },
            @{ Name = "AnyDesk"; Id = "AnyDeskSoftwareGmbH.AnyDesk"; Selected = $false; PostInstall = { } }
        )
    }
)

$index = 0
$done = $false

function DrawMenu {
    Clear-Host
    Write-Host "Wähle die Programme mit [Enter] aus. Starte Installation mit [Q]. Pfeiltasten zum Navigieren.`n"
    $i = 0
    foreach ($group in $groups) {
        Write-Host "`n== $($group.Category) =="
        foreach ($item in $group.Items) {
            $prefix = if ($i -eq $index) { ">" } else { " " }
            $selectedMark = if ($item.Selected) { "[X]" } else { "[ ]" }
            Write-Host "$prefix $selectedMark $($item.Name)"
            $i++
        }
    }
}

$flatList = @()
foreach ($group in $groups) {
    # Einzelne Programme einfügen (auswählbar)
    foreach ($item in $group.Items) {
        $flatList += @{ Type = "Item"; Ref = $item }
    }
}


while (-not $done) {
    DrawMenu
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    switch ($key.VirtualKeyCode) {
        38 { if ($index -gt 0) { $index-- } }                       # Hoch
        40 { if ($index -lt $flatList.Count - 1) { $index++ } }     # Runter
        13 {                                                        # Enter
            $current = $flatList[$index]
            if ($current.Type -eq "Item") {
                $current.Ref.Selected = -not $current.Ref.Selected
            }
        } 
        81 { $done = $true }                                        # Q
    }
}

# Begin installation
Clear-Host
Write-Host "`nStarte Installation:`n"

foreach ($group in $groups) {
    foreach ($app in $group.Items) {
        if ($app.Selected) {
            Write-Host "Installiere: $($app.Name)..."
            try {
                winget install --id $app.Id -e --silent
                Write-Host "Erfolgreich installiert: $($app.Name)" -ForegroundColor Green
                if ($app.PostInstall) {
                    Write-Host "Führe Post-Installationsschritte für $($app.Name) aus..."
                    & $app.PostInstall
                    Write-Host "Post-Installationsschritte abgeschlossen für: $($app.Name)" -ForegroundColor Green
                }
            } catch {
                Write-Host "Fehler bei: $($app.Name)" -ForegroundColor Red
            }
        }
    }
}
Write-Host "Fertig!" -ForegroundColor Green


# Interaktive App-Auswahl mit Gruppierung und Tastennavigation

# $groups muss vorab definiert sein – jede Gruppe enthält Category & Items

# Flache Liste mit Gruppentyp für Navigation erzeugen
$flatList = @()
foreach ($group in $groups) {
    $flatList += @{ Type = "Group"; Label = $group.Category }
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

foreach ($group in $groups) {
    foreach ($app in $group.Items) {
        if ($app.Selected) {
            Write-Host "Installiere $($app.Name)..."
            try {
                winget install --id $app.Id -e --silent --accept-package-agreements --accept-source-agreements
            } catch {
                Write-Host "Fehler bei $($app.Name): $_" -ForegroundColor Red
            }
        }
    }
}

Write-Host "`nAlle ausgewählten Programme wurden verarbeitet." -ForegroundColor Green

Write-Host "`nEntferne Desktop-Verknüpfungen..."
Remove-Item "$env:PUBLIC\Desktop\*.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:USERPROFILE\Desktop\*.lnk" -Force -ErrorAction SilentlyContinue

Write-Host "`nAktualisiere installiere Programme..."
winget upgrade --all --accept-package-agreements --accept-source-agreements

Write-Host "`nInstalliere Windows Update Ohne Reboot"
Install-WindowsUpdate -AcceptAll -IgnoreReboot

Write-Host "`nLösche Alle Dateien im TEMP Ordner"
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

$choice = Read-Host "System jetzt neu starten? (J/N)"
if ($choice -eq "J") {
    Restart-Computer -Force
}

# 