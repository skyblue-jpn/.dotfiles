{ pkgs, lib, ... }:

{
  imports = [
    ./filesystems
    ./networking
    ./performance
    ./virtualisation
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

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

  nixpkgs.config.allowBroken = true;
}
