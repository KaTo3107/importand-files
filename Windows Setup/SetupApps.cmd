@echo off
REM Warte auf Netzwerkverbindung (optional)
timeout /t 10

REM Stelle sicher, dass Winget verfügbar ist
echo Warten auf winget...
:wingetCheck
where winget >nul 2>&1
if errorlevel 1 (
    timeout /t 5
    goto :wingetCheck
)

REM Programme installieren
echo Installiere Programme...

winget install --id=Valve.Steam -e
winget install --id=Microsoft.VisualStudioCode -e
winget install --id=7zip.7zip -e
winget install --id=GOG.Galaxy -e
winget install --id=Git.Git -e

REM Languagetool
winget install --id=9PFZ3G4D1C9R -e 

REM Jetbrains Toolbox
winget install --id=XPFPPN5PLH3BFV -e 

winget install --id=EpicGames.EpicGamesLauncher -e

winget install --id=ElectronicArts.EADesktop -e --accept-source-agreements --accept-package-agreements
winget install --id=RiotGames.LeagueOfLegends.EUW -e --accept-source-agreements --accept-package-agreements
winget install --id=RiotGames.Valorant.EU -e --accept-source-agreements --accept-package-agreements
winget install --id=OBSProject.OBSStudio -e --accept-source-agreements --accept-package-agreements
winget install --id=Microsoft.WindowsTerminal -e --accept-source-agreements --accept-package-agreements
winget install --id=Discord.Discord -e --accept-source-agreements --accept-package-agreements
winget install --id=Bitwarden.Bitwarden -e --accept-source-agreements --accept-package-agreements
winget install --id=JanDeDobbeleer.OhMyPosh -e --accept-source-agreements --accept-package-agreements
winget install --id=DeepL.DeepL -e --accept-source-agreements --accept-package-agreements

REM Whatsapp Beta
winget install --id=9NBDXK71NK08 -e --accept-source-agreements --accept-package-agreements

REM Remove Desktop-Verknüpfungen
echo Entferne Desktop-Verknüpfungen...
Remove-Item "$env:PUBLIC\Desktop\*.lnk" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:USERPROFILE\Desktop\*.lnk" -Force -ErrorAction SilentlyContinue

REM Desktop-Verknüpfungen entfernen
echo Entferne Desktop-Icons...
powershell -Command "Remove-Item 'C:\Users\Public\Desktop\*.lnk','$env:USERPROFILE\Desktop\*.lnk' -Force -ErrorAction SilentlyContinue"

REM Updates durchführen
echo Aktualisiere installierte Programme...
winget upgrade --all --accept-package-agreements --accept-source-agreements
