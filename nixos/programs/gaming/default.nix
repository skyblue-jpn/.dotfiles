{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Gaming packages
  environment.systemPackages = with pkgs; [
    lutris
    mangohud
    prismlauncher
    (retroarch.overrideAttrs (oldAttrs: {
      cores = with libretro; [
        citra
        flycast
        ppsspp
      ];
    }))
    wine-staging
    winetricks
  ];

  # Enable gamemode
  programs.gamemode.enable = true;

  # Enable Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
}
