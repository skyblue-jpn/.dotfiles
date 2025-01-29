{ config, pkgs, ... }:

{
  # Steamをインストール
  # Proton ExperimentalはSteamの設定から有効化する
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
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
