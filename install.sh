#!/bin/bash
set -euo pipefail

write_miserc() {
  sudo mkdir -p /etc/mise

  sudo tee /etc/mise/miserc.toml >/dev/null <<EOF
env = ["$env"]
env_conf_d = true
auto_env = true
EOF
}

setup_home-linux() {
  sudo pacman -Syyu --noconfirm
  sudo pacman -S --noconfirm --needed extra/mise fish
}

setup_work-wsl() {
  sudo add-apt-repository -y ppa:fish-shell/release-4
  sudo add-apt-repository -y ppa:jdxcode/mise
  sudo apt update
  sudo apt install -y mise fish
}

echo "Select Your Config Environment:"

PS3="> "

select env in home-linux work-wsl; do
  if [ -z "$env" ]; then
    echo "Invalid selection. Exiting."
    exit 1
  fi

  write_miserc

  case "$env" in
  home-linux)
    setup_home-linux
    ;;
  work-wsl)
    setup_work-wsl
    ;;
  esac

  mise -E "$env" bootstrap --adopt skyblue-jpn/.dotfiles --yes --force-dotfiles

  break
done
