{pkgs, ...}:

{
  programs = {
    # shell
    fish = {
      enable = true;
    };
    xonsh = {
      enable = true;
    };
    # tools
    dconf = {
      enable = true;
    };
    gnome-disks = {
      enable = true;
    };
    file-roller = {
      enable = true;
    };
    kdeconnect = {
      enable = true;
    };
    noisetorch = {
      enable = true;
    };
    # gaming
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
