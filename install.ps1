#requires -Version 5.1
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$Repository = 'skyblue-jpn/.dotfiles'
$RestartedForPowerShell7 = $env:DOTFILES_RESTARTED_FOR_PWSH7 -eq '1'

function Write-Step([string]$Message) {
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Assert-Command([string]$Name) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command not found: $Name"
    }
}

function Install-WingetPackage([string]$Id) {
    winget install --id $Id --exact --source winget `
        --accept-source-agreements --accept-package-agreements
    if ($LASTEXITCODE -ne 0) {
        throw "winget failed to install $Id (exit code $LASTEXITCODE)"
    }
}

function Update-SessionPath {
    $machinePath = [Environment]::GetEnvironmentVariable('Path', 'Machine')
    $userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
    $env:Path = "$machinePath;$userPath"
}

Assert-Command winget

if ($PSVersionTable.PSVersion.Major -lt 7 -or
    $PSVersionTable.PSEdition -ne 'Core') {
    if (-not $RestartedForPowerShell7) {
        Write-Step 'Installing PowerShell 7'
        Install-WingetPackage 'Microsoft.PowerShell'
        $pwsh = (Get-Command pwsh -ErrorAction SilentlyContinue).Source
        if (-not $pwsh) {
            Update-SessionPath
            $pwsh = (Get-Command pwsh -ErrorAction SilentlyContinue).Source
        }
        if (-not $pwsh) {
            throw 'PowerShell 7 was installed but pwsh.exe is not available'
        }
        $env:DOTFILES_RESTARTED_FOR_PWSH7 = '1'
        & $pwsh -NoProfile -File $PSCommandPath @args
        exit $LASTEXITCODE
    }
    throw 'PowerShell 7 is required'
}

Write-Step 'Installing Git and mise'
Install-WingetPackage 'Git.Git'
Install-WingetPackage 'jdx.mise'
Update-SessionPath
Assert-Command mise

[Environment]::SetEnvironmentVariable('MISE_ENV', 'home-windows', 'User')

Write-Step 'Applying mise configuration'
mise -E home-windows bootstrap --adopt $Repository --yes --force-dotfiles
if ($LASTEXITCODE -ne 0) {
    throw "mise bootstrap failed (exit code $LASTEXITCODE)"
}

Write-Host "`nWindows setup completed." -ForegroundColor Green
