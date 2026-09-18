$ProfileDir = Split-Path -Parent $PROFILE

# Sync Completions
if (Test-Path "$ProfileDir\completions") {
    Get-ChildItem -Path "$ProfileDir\completions" -Filter "*.ps1" -Recurse | ForEach-Object { . $_.FullName }
}

# Sync Functions
if (Test-Path "$ProfileDir\functions") {
    Get-ChildItem -Path "$ProfileDir\functions" -Filter "*.ps1" -Recurse | ForEach-Object { . $_.FullName }
}
