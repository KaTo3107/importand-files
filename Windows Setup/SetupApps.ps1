# Define applications
enum InstallType {
    Winget
    SetupScript
}

# Gruppen und Items als einfache Hashtables/Arrays definieren, InstallType als Enum verwenden
$groups = @(
    @{
        Name = "Browser"
        Items = @(
            @{ Name = "Google Chrome"; Id = "Google.Chrome"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Mozilla Firefox"; Id = "Mozilla.Firefox"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 }
        )
    },
    @{
        Name = "Archivierung & Packprogramme"
        Items = @(
            @{
                Name = "WinRAR"
                Id = "RARLab.WinRAR"
                Selected = $false
                PostInstall = {
                    if (Test-Path "C:\Windows\Setup\Scripts\rarreg.key") {
                        Copy-Item "C:\Windows\Setup\Scripts\rarreg.key" -Destination "$env:ProgramFiles\WinRAR\" -Force
                    }
                }
                InstallType = [InstallType]::Winget
                Index = 1000
            },
            @{ Name = "7-Zip"; Id = "7zip.7zip"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 }
        )
    },
    @{
        Name = "Gaming"
        Items = @(
            @{ Name = "Steam"; Id = "Valve.Steam"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Battle.net"; Id = "Blizzard.BattleNet"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Epic Games Launcher"; Id = "EpicGames.EpicGamesLauncher"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "EA Launcher"; Id = "ElectronicArts.EADesktop"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "League Of Legends ( Maybe nur Riot Client download )"; Id = "RiotGames.LeagueOfLegends.EUW"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Valorant ( Maybe nur Riot Client download )"; Id = "RiotGames.Valorant.EU"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 }
        )
    },
    @{
        Name = "Multimedia & Kommunikation"
        Items = @(
            @{ Name = "VLC Player"; Id = "VideoLAN.VLC"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "GIMP"; Id = "GIMP.GIMP"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Bambu Lab Studio"; Id = "bambulab.bambulab-studio"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Teamspeak 6"; Id = "TeamSpeakSystems.TeamSpeak"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Whatsapp"; Id = "9NKSQGP7F2NH"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Whatsapp Beta"; Id = "9NBDXK71NK08"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "OBS Studio"; Id = "OBSProject.OBSStudio"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Discord"; Id = "Discord.Discord"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 }
        )
    },
    @{
        Name = "Tools & Dienstprogramme"
        Items = @(
            @{ Name = "CPU-Z"; Id = "CPUID.CPU-Z"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Wireshark"; Id = "WiresharkFoundation.Wireshark"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = ".NET Framework Developer Pack"; Id = "Microsoft.DotNet.Framework.DeveloperPack_4"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "WinOF1 - Network Driver"; Id = "WinOF1.exe"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::SetupScript; Index = 0, Arguments = "/S /v/qn /norestart" },
            @{ Name = "WinOF2 - Network Driver"; Id = "WinOF2.exe"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::SetupScript; Index = 0, Arguments = "/S /v/qn /norestart" },
            @{ Name = "Lightshot"; Id = "Skillbrains.Lightshot"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Bitwarden"; Id = "Bitwarden.Bitwarden"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Languagetool"; Id = "9PFZ3G4D1C9R"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 }
        )
    },
    @{
        Name = "Entwicklung & Editoren"
        Items = @(
            @{ Name = "Notepad++"; Id = "Notepad++.Notepad++"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Visual Studio Code"; Id = "Microsoft.VisualStudioCode"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Jetbrains Toolbox"; Id = "XPFPPN5PLH3BFV"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Git"; Id = "Git.Git"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Windows Terminal"; Id = "Microsoft.WindowsTerminal"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "Oh My Posh"; Id = "JanDeDobbeleer.OhMyPosh"; Selected = $true; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 }
        )
    },
    @{
        Name = "Dateiübertragung & Remote-Zugriff"
        Items = @(
            @{ Name = "MobaXterm"; Id = "Mobatek.MobaXterm"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "WinSCP"; Id = "WinSCP.WinSCP"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "TeamViewer"; Id = "TeamViewer.TeamViewer"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 },
            @{ Name = "AnyDesk"; Id = "AnyDeskSoftwareGmbH.AnyDesk"; Selected = $false; PostInstall = $null; InstallType = [InstallType]::Winget; Index = 1000 }
        )
    }
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
                    & $scriptPath $app.Arguments
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
