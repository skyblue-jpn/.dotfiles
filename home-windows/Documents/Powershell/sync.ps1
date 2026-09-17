$ProfileDir = Split-Path -Parent $PROFILE

# Sync Completions
if (Test-Path "$ProfileDir\Completions") {
    Get-ChildItem -Path "$ProfileDir\Completions" -Filter "*.ps1" -Recurse | ForEach-Object { . $_.FullName }
}

# Sync Functions
if (Test-Path "$ProfileDir\Functions") {
    Get-ChildItem -Path "$ProfileDir\Functions" -Filter "*.ps1" -Recurse | ForEach-Object { . $_.FullName }
}
