#!/bin/bash
set -euo pipefail

sudo pacman -S --noconfirm --needed extra/mise fish

mise bootstrap --from https://github.com/skyblue-jpn/.dotfiles.git --from-dir ~/.dotfiles --yes --force-dotfiles
