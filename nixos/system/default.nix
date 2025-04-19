{ pkgs, lib, ... }:

{
  imports = [
    ./filesystems
    ./networking
    ./performance
  ];
  # Environment packages
  environment.systemPackages = with pkgs; [
    floorp
    git
    neovim
    nixfmt-rfc-style
    vscode
  ];

  # Nix configuration
  nix = {
    settings = {
      # Enable experimental features
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # Allow unfree software
  nixpkgs.config.allowUnfree = true;

  # Security related settings
  security.rtkit.enable = true;

  # Various services configuration
  services = {
    # Enable libinput (driver for mouse and keyboard)
    libinput = {
      enable = true;
      touchpad = {
        tapping = false;
        scrollMethod = "twofinger";
        naturalScrolling = false;
        disableWhileTyping = true;
      };
    };
    # Enable printing service
    printing.enable = true;
    # X server configuration (basic for GUI environment)
    xserver = {
      enable = true;
      # XKB configuration (keyboard layout)
      xkb = {
        layout = "us";
        variant = "";
      };
    };
  };
  hardware = {
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };

  # System version
  system.stateVersion = "25.05";

  # Time related settings
  time = {
    # Use hardware clock in local time
    hardwareClockInLocalTime = true;
    # Set the time zone
    timeZone = "Asia/Tokyo";
  };

  # User related settings
  users.extraGroups.vboxusers.members = [ "celeste" ];

  # Virtualization related settings
  virtualisation.virtualbox = {
    # Enable VirtualBox host features
    host.enable = false;
    # Do not add host network interface
    host.addNetworkInterface = false;
    # Enable Extension Pack
    host.enableExtensionPack = true;
    # Enable KVM support
    host.enableKvm = true;
    # Disable VirtualBox guest features
    guest.enable = false;
    # Enable drag and drop with guest OS
    guest.dragAndDrop = true;
    # Enable clipboard sharing with guest OS
    guest.clipboard = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
