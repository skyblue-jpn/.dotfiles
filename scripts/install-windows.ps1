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

function Resolve-MiseExe {
  $cmd = Get-Command mise -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }

  $machine = [Environment]::GetEnvironmentVariable("Path", "Machine")
  $user    = [Environment]::GetEnvironmentVariable("Path", "User")
  $env:Path = "$machine;$user"

  $cmd = Get-Command mise -ErrorAction SilentlyContinue
  if ($cmd) { return $cmd.Source }

  $candidates = @(
    (Join-Path $env:LOCALAPPDATA "Microsoft\WinGet\Links\mise.exe"),
    (Join-Path $env:LOCALAPPDATA "Programs\mise\bin\mise.exe")
  )
  foreach ($p in $candidates) {
    if (Test-Path $p) { return $p }
  }

  return $null
}

Require-Command winget "Install 'App Installer' from Microsoft Store."

winget install jdx.mise --accept-source-agreements --accept-package-agreements

Write-Miserc $envName

$miseExe = Resolve-MiseExe
if (-not $miseExe) {
  throw "mise was installed but not available in current session. Open a new PowerShell and run: mise -E $envName bootstrap --adopt $repo --yes --force-dotfiles"
}

& $miseExe -E $envName bootstrap --adopt $repo --yes --force-dotfiles

Write-Host "Done."
