#!/bin/sh

# エラーが発生した場合にスクリプトを停止
set -e || exit

# スクリプトが存在するディレクトリに移動
cd "$(dirname "$0")"

# フレークを更新
nix flake update

# コマンドを実行
sudo nixos-rebuild switch --flake .#myNixOS --install-bootloader
nix run nixpkgs#home-manager -- switch --flake .#myHome
sudo nix store gc
