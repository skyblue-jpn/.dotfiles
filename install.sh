#!/bin/bash
set -euo pipefail

write_miserc_unix() {
  sudo mkdir -p /etc/mise

  sudo tee /etc/mise/miserc.toml >/dev/null <<EOF
env = ["$env"]
EOF
}

write_miserc_windows() {
  setx MISE_ENV "home-windows"
}

setup_home-linux() {
  sudo pacman -Syyu --noconfirm
  sudo pacman -S --noconfirm --needed extra/mise fish
}

setup_home-windows() {
  winget upgrade --all
  winget install Git.Git jdx.mise
  mise self-update
}

setup_work-wsl() {
  sudo add-apt-repository -y ppa:fish-shell/release-4
  sudo add-apt-repository -y ppa:jdxcode/mise
  sudo apt update
  sudo apt install -y mise fish
}

echo "Select Your Config Environment:"

PS3="> "

select env in home-linux home-windows work-wsl; do
  if [ -z "$env" ]; then
    echo "Invalid selection. Exiting."
    exit 1
  fi

  case "$env" in
  home-linux)
    write_miserc_unix
    setup_home-linux
    ;;
  home-windows)
    write_miserc_windows
    setup_home-windows
    ;;
  work-wsl)
    write_miserc_unix
    setup_work-wsl
    ;;
  esac

  mise -E "$env" bootstrap --adopt skyblue-jpn/.dotfiles --yes --force-dotfiles

  break
done
