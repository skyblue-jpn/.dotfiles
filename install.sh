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
  local environment="$1"

  sudo mkdir -p /etc/mise
  sudo tee /etc/mise/miserc.toml >/dev/null <<EOF
env = ["$environment"]
EOF
}

setup_distro_cachyos() {
  require_command sudo
  require_command pacman
  if command -v cachyos-rate-mirrors >/dev/null 2>&1; then
    sudo cachyos-rate-mirrors
  fi
  sudo pacman -Syu --noconfirm
  sudo pacman -S --noconfirm --needed curl mise fish git
}

setup_distro_ubuntu() {
  require_command sudo
  require_command apt
  sudo apt update
  sudo apt install -y curl git software-properties-common

  if ! command -v mise >/dev/null 2>&1; then
    sudo add-apt-repository -y ppa:jdxcode/mise
    sudo apt update
    sudo apt install -y mise
  fi

  # Remove repository files created by add-apt-repository so they do not conflict
  # with the deb822 sources managed by mise in [bootstrap.apt.sources].
  sudo rm -f /etc/apt/sources.list.d/jdxcode-ubuntu-mise.sources
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

select env in home-main-linux home-sub-linux home-windows work-wsl; do
  if [ -z "$env" ]; then
    echo "Invalid selection. Exiting." >&2
    exit 1
  fi

  case "$env" in
  home-main-linux | home-sub-linux)
    write_miserc_unix "$env"
    setup_distro_cachyos
    run_bootstrap "$env"
    ;;
  home-windows)
    die "Run install.ps1 from PowerShell for the Windows environment."
    ;;
  work-wsl)
    write_miserc_unix "$env"
    setup_distro_ubuntu
    run_bootstrap "$env"
    ;;
  esac

  break
done
