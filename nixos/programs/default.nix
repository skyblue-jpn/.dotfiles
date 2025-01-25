{pkgs, ...}:

{
  programs = {
    fish = {
      enable = true;
    };
    xonsh = {
      enable = true;
    };
    kdeconnect = {
      enable = true;
    };
    noisetorch = {
      enable = true;
    };
    gnome-disks = {
      enable = true;
    };
    file-roller = {
      enable = true;
    };
    dconf = {
      enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
