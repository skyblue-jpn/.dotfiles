#!/usr/bin/env bash
set -euo pipefail

REPO="skyblue-jpn/.dotfiles"

write_miserc_unix() {
  local env_name="$1"
  sudo mkdir -p /etc/mise
  sudo tee /etc/mise/miserc.toml >/dev/null <<EOF
env = ["$env_name"]
env_conf_d = true
auto_env = true
EOF
}

setup_home_linux() {
  sudo pacman -Syyu --noconfirm
  sudo pacman -S --noconfirm --needed extra/mise fish
}

setup_work_wsl() {
  sudo add-apt-repository -y ppa:fish-shell/release-4
  sudo add-apt-repository -y ppa:jdxcode/mise
  sudo apt update
  sudo apt install -y mise fish
}

main() {
  echo "Select environment:"
  PS3="> "
  select env in home-linux home-windows work-wsl; do
    [[ -n "${env:-}" ]] || { echo "Invalid selection"; exit 1; }

    case "$env" in
      home-linux)
        write_miserc_unix "$env"
        setup_home_linux
        ;;
      work-wsl)
        write_miserc_unix "$env"
        setup_work_wsl
        ;;
      home-windows)
        echo "Windows environment selected. Please run from Windows host:"
        echo "  ./install"
        exit 1
        ;;
    esac

    mise -E "$env" bootstrap --adopt "$REPO" --yes --force-dotfiles
    break
  done
}

main "$@"
