{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cloneLazyVim = pkgs.runCommand "clone-lazyvim" { } ''
    git clone https://github.com/LazyVim/starter $out
    rm -rf $out/.git
  '';
in
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim".source = cloneLazyVim;
}
