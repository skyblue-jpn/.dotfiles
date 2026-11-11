#!/bin/bash
set -euo pipefail

readonly REPOSITORY="skyblue-jpn/.dotfiles"

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"
}

write_miserc_unix() {
  sudo mkdir -p /etc/mise

  sudo tee /etc/mise/miserc.toml >/dev/null <<EOF
env = ["$env"]
EOF
}

setup_home-linux() {
  require_command sudo
  require_command pacman
  sudo pacman -Syu --noconfirm
  sudo pacman -S --noconfirm --needed curl extra/mise fish git
}

setup_work-wsl() {
  require_command sudo
  require_command apt
  sudo apt update
  sudo apt install -y curl git software-properties-common

  for repo in \
    ppa:fish-shell/release-4 \
    ppa:jdxcode/mise \
    ppa:git-core/ppa \
    ppa:apt-fast/stable; do
    sudo add-apt-repository -y "$repo"
  done

  sudo apt update
  sudo apt install -y mise fish apt-fast
}

run_bootstrap() {
  local environment="$1"

  require_command mise
  sudo -v
  mise -E "$environment" bootstrap \
    --adopt "$REPOSITORY" \
    --yes \
    --force-dotfiles
}

echo "Select your config environment:"

PS3="> "

select env in home-linux home-windows work-wsl; do
  if [ -z "$env" ]; then
    echo "Invalid selection. Exiting." >&2
    exit 1
  fi

  case "$env" in
  home-linux)
    write_miserc_unix
    setup_home-linux
    run_bootstrap "$env"
    ;;
  home-windows)
    die "Run install.ps1 from PowerShell for the Windows environment."
    ;;
  work-wsl)
    write_miserc_unix
    setup_work-wsl
    run_bootstrap "$env"
    ;;
  esac

  break
done
