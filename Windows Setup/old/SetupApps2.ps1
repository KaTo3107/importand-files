# Define applications
# Define applications
$groups = @(
    @{ 
        Category = "Browser"
        Items = @(
            @{ Name = "Google Chrome"; Id = "Google.Chrome"; Selected = $false },
            @{ Name = "Mozilla Firefox"; Id = "Mozilla.Firefox"; Selected = $false }
        )
    },
    @{ 
        Category = "Archivierung & Packprogramme"
        Items = @(
            @{ Name = "WinRAR"; Id = "RARLab.WinRAR"; Selected = $false },
            @{ Name = "7-Zip"; Id = "7zip.7zip"; Selected = $true }
        )
    },
    @{
        Category = "Gaming"
        Items = @(
            @{ Name = "Steam"; Id = "Valve.Steam"; Selected = $true },
            @{ Name = "Battle.net"; Id = "Blizzard.BattleNet"; Selected = $false },
            @{ Name = "Epic Games Launcher"; Id = "EpicGames.EpicGamesLauncher"; Selected = $false },
            @{ Name = "EA Launcher"; Id = "ElectronicArts.EADesktop"; Selected = $false },
            @{ Name = "League Of Legends ( Maybe nur Riot Client download )"; Id = "RiotGames.LeagueOfLegends.EUW"; Selected = $false },
            @{ Name = "Valorant ( Maybe nur Riot Client download )"; Id = "RiotGames.Valorant.EU"; Selected = $false }
        )
    },
    @{ 
        Category = "Multimedia & Kommunikation"
        Items = @(
            
            @{ Name = "VLC Player"; Id = "VideoLAN.VLC"; Selected = $false },
            @{ Name = "GIMP"; Id = "GIMP.GIMP"; Selected = $false },
            @{ Name = "Bambu Lab Studio"; Id = "bambulab.bambulab-studio"; Selected = $false },
            @{ Name = "Teamspeak 6"; Id = "TeamSpeakSystems.TeamSpeak"; Selected = $false },
            @{ Name = "Whatsapp Beta"; Id = "9NBDXK71NK08"; Selected = $true },
            @{ Name = "OBS Studio"; Id = "OBSProject.OBSStudio"; Selected = $true },
            @{ Name = "TeamViewer"; Id = "TeamViewer.TeamViewer"; Selected = $false },
            @{ Name = "Discord"; Id = "Discord.Discord"; Selected = $true }
        )
    },
    @{ 
        Category = "Tools & Dienstprogramme"
        Items = @(
            @{ Name = "CPU-Z"; Id = "CPUID.CPU-Z"; Selected = $false },
            @{ Name = "Wireshark"; Id = "WiresharkFoundation.Wireshark"; Selected = $false },
            @{ Name = ".NET Framework Developer Pack"; Id = "Microsoft.DotNet.Framework.DeveloperPack_4"; Selected = $false },
            @{ Name = "NVIDIA Treiber (WinOF 1)"; Id = "Mellanox.MFT"; Selected = $false },
            @{ Name = "NVIDIA Treiber (WinOF 2)"; Id = "Mellanox.WinOF2"; Selected = $false },
            @{ Name = "Lightshot"; Id = "Skillbrains.Lightshot"; Selected = $false },
            @{ Name = "Bitwarden"; Id = "Bitwarden.Bitwarden"; Selected = $false },
            @{ Name = "Languagetool"; Id = "9PFZ3G4D1C9R"; Selected = $false }
        )
    },
    @{ 
        Category = "Entwicklung & Editoren"
        Items = @(
            @{ Name = "Notepad++"; Id = "Notepad++.Notepad++"; Selected = $true },
            @{ Name = "Visual Studio Code"; Id = "Microsoft.VisualStudioCode"; Selected = $true },
            @{ Name = "Jetbrains Toolbox"; Id = "XPFPPN5PLH3BFV"; Selected = $true },
            @{ Name = "Git"; Id = "Git.Git"; Selected = $true },
            @{ Name = "Windows Terminal"; Id = "Microsoft.WindowsTerminal"; Selected = $true },
            @{ Name = "Oh My Posh"; Id = "JanDeDobbeleer.OhMyPosh"; Selected = $true }
        )
    },
    @{ 
        Category = "Dateiübertragung & Remote-Zugriff"
        Items = @(
            @{ Name = "MobaXterm"; Id = "Mobatek.MobaXterm"; Selected = $false },
            @{ Name = "FileZilla"; Id = "FileZilla.FileZilla"; Selected = $false },
            @{ Name = "WinSCP"; Id = "WinSCP.WinSCP"; Selected = $false },
            @{ Name = "AnyDesk"; Id = "AnyDeskSoftwareGmbH.AnyDesk"; Selected = $false }
        )
    }
)

$index = 0
$done = $false

function DrawMenu {
    Clear-Host
    Write-Host "Wähle die Programme mit [Enter] aus. Starte Installation mit [Q]. Pfeiltasten zum Navigieren.`n "

    for ($i = 0; $i -lt $groups.Count; $i++) {
        
        $apps = $groups[$i].Items
        foreach ($app in $apps) {
            $prefix = if ($apps.Selected) { "[X]" } else { "[ ]" }
            $highlight = if ($i -eq $index) { ">" } else { " " }
            Write-Host "$highlight $prefix $($apps.Name)"
        }
    }
}

while (-not $done) {
    DrawMenu
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    switch ($key.VirtualKeyCode) {
        38 { if ($index -gt 0) { $index-- } }            # Up arrow
        40 { if ($index -lt $apps.Count - 1) { $index++ } }  # Down arrow
        13 {                                             # Enter
            $apps[$index].Selected = -not $apps[$index].Selected
        }
        81 { $done = $true }                             # Q
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
            } catch {
                Write-Host "Fehler bei: $($app.Name)" -ForegroundColor Red
            }
        }
    }
}
Write-Host "Fertig!" -ForegroundColor Green
