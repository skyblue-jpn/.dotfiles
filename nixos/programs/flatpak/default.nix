{ pkgs, ... }:

{
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  services.flatpak = {
    enable = true;
    packages = [
      "com.usebottles.bottles"
    ];
    update.onActivation = true;
    update.auto = {
      enable = true;
      onCalendar = "weekly"; # Default value
    };
  };
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
