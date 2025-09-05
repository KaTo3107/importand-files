# Installation of Oh My Posh with My Preferences
# Windows | Powershell
### Install Oh My Posh
<code>winget install JanDeDobbeleer.OhMyPosh --source winget --scope user --force</code>

### Add to Path
<code>$env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin"</code>

### Test Oh my Posh
<code> (Get-Command oh-my-posh).Source </code
Restart TERMINAL

### Add Nerd Font for Oh My posh
<code>oh-my-posh font install CascadiaMono</code>

### Get My Theme for Oh My Posh
Copy the kato-paradox.omp.json into $env:POSH_THEMES_PATH

# More Information

Oh My Posh: https://ohmyposh.dev/docs
Nerd Fonts: https://www.nerdfonts.com/font-downloads
