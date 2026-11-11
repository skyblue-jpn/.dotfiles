# Dotfiles

## Environments

### Home-Linux

- CachyOS
- Catppuccin Macchiato
- Bash installer: `install.sh`

### Home-Windows

- Windows 11 Home
- Catppuccin Macchiato
- PowerShell 7 installer: `install.ps1`

### Work-WSL

- WSL2 (Ubuntu)
- Tokyo Night Night
- Bash installer: `install.sh`

## Installation

### Linux or WSL

Run the Bash installer from a terminal:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/skyblue-jpn/.dotfiles/main/install.sh)"
```

Select `home-linux` or `work-wsl` when prompted. The installer installs the
platform prerequisites, writes the mise environment selector, and runs the
complete bootstrap. Home-Linux uses nftables explicitly so the firewall phase
does not depend on backend auto-detection.

NTFS mounts are machine-specific and are intentionally not part of mise
bootstrap. Configure them after setup with the same script for both profiles:

```bash
# Proton-compatible game partition
${HOME}/.config/mise/home-linux/scripts/mount-filesystem.sh \
  --mode game --interactive

# Other storage partitions
${HOME}/.config/mise/home-linux/scripts/mount-filesystem.sh \
  --mode storage --interactive
```

The `game` mode uses the Proton-compatible `umask=000` profile and defaults to
`/media/gamedisk`. The `storage` mode defaults to `/media/storage` and uses
`umask=022`; both modes accept the same partition, UID/GID, filesystem, and
fstab options. The interactive mode accepts multiple partition and mount-point
pairs and adds UUID-based entries to `/etc/fstab`.

A shared NTFS volume must not be mounted read-write while Windows Fast Startup
or hibernation is enabled. NTFS Steam
libraries shared with Windows are unsupported by Valve and can cause games to
crash or lose data; keep Proton `compatdata` on a Linux filesystem as
recommended by the [Proton NTFS guidance](https://github.com/ValveSoftware/Proton/wiki/Using-a-NTFS-disk-with-Linux-and-Windows).

### Windows

Run the following in PowerShell. The script installs or relaunches into
PowerShell 7 when necessary, installs Git and mise through winget, and runs
the complete `home-windows` bootstrap:

```powershell
$installer = Join-Path $env:TEMP 'dotfiles-install.ps1'
irm https://raw.githubusercontent.com/skyblue-jpn/.dotfiles/main/install.ps1 -OutFile $installer
& $installer
```

Alternatively, download `install.ps1` and run it locally:

```powershell
.\install.ps1
```
