{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Gaming packages
  environment.systemPackages = with pkgs; [
    heroic
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

    osu-lazer-bin
  ];

  environment.sessionVariables = {
    SDL_VIDEODRIVER = wayland osu!;
  };

  # Enable gamemode
  programs.gamemode.enable = true;

  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-custom
    ];
  };

  # Steamのフォントが文字化けするので、フォント設定を追加
  # SteamだけフォントをMigu 1Pにする
  fonts = {
    packages = with pkgs; [
      # ...
      migu
    ];
    fontDir.enable = true;
    fontconfig = {
      # ...
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <description>Change default fonts for Steam client</description>
          <match>
            <test name="prgname">
              <string>steamwebhelper</string>
            </test>
            <test name="family" qual="any">
              <string>sans-serif</string>
            </test>
            <edit mode="prepend" name="family">
              <string>Migu 1P</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };
}
