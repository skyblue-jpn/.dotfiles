$ProfileDir = Split-Path -Parent $PROFILE
$CompletionsDir = Join-Path $ProfileDir "completions"
$FunctionsDir = Join-Path $ProfileDir "functions"

# Sync Completions
if (Test-Path -LiteralPath $CompletionsDir) {
    Get-ChildItem -LiteralPath $CompletionsDir -Filter "*.ps1" -Recurse | ForEach-Object { . $_.FullName }
}

# Sync Functions
if (Test-Path -LiteralPath $FunctionsDir) {
    Get-ChildItem -LiteralPath $FunctionsDir -Filter "*.ps1" -Recurse | ForEach-Object { . $_.FullName }
}
