$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repo = "skyblue-jpn/.dotfiles"
$envName = "home-windows"

function Require-Command([string]$Name, [string]$Hint) {
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    throw "$Name not found. $Hint"
  }
}

function Write-Miserc([string]$Name) {
  $content = @"
env = ["$Name"]
env_conf_d = true
auto_env = true
"@

  $systemDir = Join-Path $env:ProgramData "mise"
  New-Item -ItemType Directory -Force -Path $systemDir | Out-Null
  Set-Content -Path (Join-Path $systemDir "miserc.toml") -Value $content -Encoding utf8

  $userDir = Join-Path $env:USERPROFILE ".config\mise"
  New-Item -ItemType Directory -Force -Path $userDir | Out-Null
  Set-Content -Path (Join-Path $userDir "miserc.toml") -Value $content -Encoding utf8
}

Require-Command winget "Install 'App Installer' from Microsoft Store."
winget upgrade --all --accept-source-agreements --accept-package-agreements
winget install jdx.mise --accept-source-agreements --accept-package-agreements

Write-Miserc $envName
Require-Command mise "Open a new shell once after install, then retry."
mise -E $envName bootstrap --adopt $repo --yes --force-dotfiles

Write-Host "Done."
