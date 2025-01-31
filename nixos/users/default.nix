{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.celeste = {
    isNormalUser = true;
    description = "celeste";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
    ];
    shell = pkgs.fish;
  };

  nix.settings = {
    allowed-users = [ "@wheel" ];
    trusted-users = [ "@wheel" ];
  };
}
