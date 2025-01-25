{
  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "nodev"; # Use "nodev" for UEFI, or your specific device for BIOS
    efiSupport = true; # true for UEFI, false for BIOS
    useOSProber = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Display Manager.
  environment.systemPackages = with pkgs; [
    sddm-astronaut
  ];
  services.displayManager.sddm = {
    package = pkgs.kdePackages.sddm;
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [ pkgs.sddm-astronaut ];
  };
}
