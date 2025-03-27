{ ... }:

{
  networking = {
    hostName = "aquamarine";
    networkmanager = {
      enable = true;
      unmanaged = [
        "lo"
        "docker0"
        "virbr0"
      ];
      wifi = {
        backend = "wpa_supplicant";
        powersave = false;
      };
    };
    # Disable non-NetworkManager
    useDHCP = false;
    wireless.iwd = {
      enable = true;
      settings = {
        General.AddressRandomization = "once";
        General.AddressRandomizationRange = "full";
      };
    };
    # Enable nftables
    nftables.enable = true;
  };
  # Enable wireless database
  hardware.wirelessRegulatoryDatabase = true;

  # Enable BBR & cake
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_fin_timeout" = 5;
  };

}
