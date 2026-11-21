function repo {
    param(
        [Parameter(Position = 0)]
        [string]$Action = 'list',
        [Parameter(Position = 1)]
        [string]$Arg
    )

    $ghqRoot = (ghq root)

    switch -Regex ($Action) {
        '^(list|l)$' {
            $selected = ghq list | fzf --height=50% --border --preview "echo {}" --preview-window=down:3:wrap
            if ($selected) {
                Write-Host "Selected: $selected"
                Write-Host "Path: $(Join-Path $ghqRoot $selected)"
            }
        }
        '^(cd|c)$' {
            $selected = ghq list | fzf --height=50% --border --preview "echo {}" --preview-window=down:3:wrap
            if ($selected) {
                Set-Location -LiteralPath (Join-Path $ghqRoot $selected)
            }
        }
        '^(remove|rm|r)$' {
            $selected = ghq list | fzf --height=50% --border --preview "echo {}" --preview-window=down:3:wrap --prompt "Select repository to remove: "
            if ($selected) {
                $confirm = Read-Host "Are you sure you want to remove $selected? [y/N]"
                if ($confirm -match '^[Yy]$') {
                    Remove-Item -LiteralPath (Join-Path $ghqRoot $selected) -Recurse -Force
                    Write-Host "Removed: $selected"
                } else {
                    Write-Host "Cancelled"
                }
            }
        }
        '^(get|g)$' {
            if (-not $Arg) {
                $selected = gh repo list --limit 100 --json nameWithOwner --jq '.[].nameWithOwner' |
                    fzf --height=50% --border --prompt "Select repository to clone: "
                if ($selected) {
                    ghq get "github.com/$selected"
                }
            } else {
                ghq get $Arg
            }
        }
        '^(create|new|n)$' {
            if (-not $Arg) {
                Write-Host "Usage: repo create <repository_path>"
                Write-Host "Example: repo create github.com/user/new-repo"
                return
            }
            $repoPath = Join-Path $ghqRoot $Arg
            New-Item -ItemType Directory -Path $repoPath -Force | Out-Null
            Set-Location -LiteralPath $repoPath
            git init
            Write-Host "Created and initialized: $Arg"
        }
        '^(open|o)$' {
            $editor = if ($Arg) { $Arg } else { 'zed' }
            $selected = ghq list | fzf --height=50% --border --preview "echo {}" --preview-window=down:3:wrap
            if ($selected) {
                $repoPath = Join-Path $ghqRoot $selected
                if (Get-Command $editor -ErrorAction SilentlyContinue) {
                    & $editor $repoPath
                } elseif (Get-Command zed -ErrorAction SilentlyContinue) {
                    zed $repoPath
                } elseif (Get-Command nvim -ErrorAction SilentlyContinue) {
                    nvim $repoPath
                } elseif (Get-Command code -ErrorAction SilentlyContinue) {
                    code $repoPath
                } else {
                    Write-Warning "No suitable editor found (zed, nvim, code)"
                }
            }
        }
        default {
            @"
Repository management with ghq and fzf

Usage: repo <command> [args]

Commands:
  list, l           List repositories with fzf selection
  cd, c             Change directory to selected repository
  remove, rm, r     Remove selected repository (with confirmation)
  get, g [url]      Clone repository (interactive if no url)
  create, new, n    Create and initialize a new repository
  open, o [editor]  Open repository in editor (default: zed)
  help, h           Show this help message
"@ | Write-Host
        }
    }
}
