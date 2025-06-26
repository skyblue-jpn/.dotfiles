{ config, pkgs, ... }:

{
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
    linger = true;
    autoSubUidGidRange = true;
  };

  nix.settings = {
    allowed-users = [ "@wheel" ];
    trusted-users = [ "@wheel" ];
  };
}
