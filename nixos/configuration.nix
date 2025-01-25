{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./boot
    ./desktop
    ./environment
    ./packages
    ./programs
  ];

  # Networking.
  networking.hostName = "aquamarine";
  networking.networkmanager.enable = true;
  networking.nftables.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";
  time.hardwareClockInLocalTime = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.celeste = {
    isNormalUser = true;
    description = "celeste";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    # Flakes
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # Garbage colector
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Automatic system upgrades
  #  system.autoUpgrade = {
  #    enable = true;
  #    flake = inputs.self.outPath;
  #    flags = [
  #      "--update-input"
  #      "nixpkgs"
  #      "-L" # print build logs
  #    ];
  #    dates = "02:00";
  #    randomizedDelaySec = "45min";
  #  };

  system.stateVersion = "24.11";
}
